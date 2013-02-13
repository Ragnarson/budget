require 'test_helper'
require_relative 'layout_tests'

class WalletsControllerTest < ActionController::TestCase
  include LayoutTests

  def setup
    sign_in users(:user_with_wallet_1)
  end

  def after
    DatabaseCleaner.clean
  end

  %w(index new).each do |action|
    test "when authenticated should contain login, incomes, expenses, wallets and members links for #{action}" do
      test_that_menu_is_present_on(action)
    end
    test "should be message with actual balance for #{action}" do
      test_that_should_contain_message_with_actual_balance_on(action)
    end
    test "should contain footer and this button for #{action}" do
      test_that_footer_should_contain_add_this_buttons(action)
    end
    test "should contain warning about low balance for #{action}" do
      test_of_presences_low_balance_warning(action)
    end
    test "should not contain warning about low balance for #{action}" do
      test_of_not_presences_low_balance_warning(action)
    end
    test "guest should be redirected for #{action}" do
      sign_out users(:user_with_wallet_1)
      test_that_guest_will_be_redirect(action)
    end
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:wallet)
  end

  test "should contain link to adding new wallet" do
    get :index
    assert_select 'div.form-actions.hidden-phone a', I18n.t('add_wallet')
    assert_select 'div.form-actions.visible-phone a', I18n.t('add_wallet')
  end

  test "should be form on new wallet page" do
    get :new
    assert_select 'form' do
      assert_select 'input#wallet_name'
      assert_select 'input#wallet_amount'
      assert_select 'input[TYPE=submit]'
      assert_select 'a', I18n.t('back.wallets')
    end
  end

  test "should be form on edit wallet page" do
    get :edit, id: wallets(:test_10000_dollars).id
    assert_select 'form' do
      assert_select 'input#wallet_name'
      assert_select 'input#wallet_amount'
      assert_select 'input[TYPE=submit]'
      assert_select 'a', I18n.t('back.wallets')
    end
  end

  test "should create wallet and redirect to new with notice" do
    post :create, wallet: {name: 'Some title'}
    assert_redirected_to :wallets
    assert_equal I18n.t('flash.wallet_success', name: 'Some title'), flash[:notice]
  end

  test "should show error when name is empty" do
    post :create, wallet: {name: ''}
    assert_tag tag: 'span', content: I18n.t('errors.messages.blank')
    assert_template :new
  end

  test "if no wallets are present should redirect to new wallet page" do
    sign_in users(:user_without_wallet)
    get :index
    assert_redirected_to :new_wallet
  end

  test "if wallets are present should show table with wallets list" do
    post :create, wallet: {name: 'Wallet name', amount: 500}
    get :index
    assert_tag tag: 'table', attributes: {class: 'table table-striped'}
  end

  test "if wallet was created, amount should be visible in table on index page" do
    post :create, wallet: {name: 'Wallet name', amount: 10}
    get :index
    assert_select 'tbody tr:last-child td:nth-child(2)', number_to_currency(10)
  end

  test "if wallet with expenses were created, wallet amount should be equal to the sum of amounts in expenses" do
    post :create, wallet: {name: 'Wallet name', amount: 300, expenses_attributes: {0 => {name: 'food', amount: 34, execution_date: '2012-11-12'}, 1 => {name: 'food2', amount: 6, execution_date: '2012-11-12'}}}
    get :index
    assert_select 'tbody tr:last-child td:nth-child(2)', number_to_currency(40)
  end

  test "should not update wallet if name is empty" do
    put :update, id: wallets(:test_10000_dollars), wallet: {amount: 200, name: ''}
    assert_template :edit
    assert_tag tag: 'span', content: I18n.t('errors.messages.blank')
  end

  test "should not update other users wallet" do
    put :update, id: wallets(:cars_10000000_dollars), wallet: {user_id: users(:user_with_wallet_1), amount: 200, name: 'something'}
    assert_redirected_to :wallets
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.wallet')), flash[:notice]
  end

  test "should update user wallet" do
    put :update, id: wallets(:test_10000_dollars), wallet: {amount: 200, name: 'something'}
    assert_redirected_to :wallets
    assert_equal I18n.t('flash.update_one', model: I18n.t('activerecord.models.wallet')), flash[:notice]
  end

  test "before destroy wallet with expenses user should see confirm_destroy action" do
    wallet = wallets(:test_10000_dollars)
    get :confirm_destroy, wallet_id: wallet.id
    assert_template :confirm_destroy
    assert_tag tag: 'ul', attributes: {class: 'expenses'}
    assert_select 'ul.expenses' do
      assert_select "li", wallet.expenses_number
    end
  end

  test "wallet without expenses should be destroyed without confirmation page" do
    wallet_id = wallets(:wallet_without_expenses).id
    get :confirm_destroy, wallet_id: wallet_id
    assert_redirected_to action: :destroy, wallet_id: wallet_id, confirmed: 1
    get :destroy, wallet_id: wallet_id, confirmed: 1
    assert_redirected_to :wallets
  end

  test "should delete wallet with expenses" do
    wallet = wallets(:test_10000_dollars)
    wallet_expenses = wallet.expenses_number
    all_expenses = Expense.count
    assert_difference 'Wallet.count', -1 do
      get :destroy, wallet_id: wallet.id, confirmed: 2
    end
    assert_equal Expense.count, (all_expenses-wallet_expenses)
    assert_redirected_to :wallets
  end

  test "should delete wallet without expenses" do
    wallet = wallets(:test_10000_dollars)
    all_expenses = Expense.count
    assert_difference 'Wallet.count', -1 do
      get :destroy, wallet_id: wallet.id, confirmed: 1
    end
    assert_equal Expense.count, all_expenses
    assert_redirected_to :wallets
  end

  test "should not destroy expense which belongs to another user" do
    assert_no_difference('Wallet.count') do
      get :destroy, wallet_id: wallets(:cars_10000000_dollars).id, confirmed: 1
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.wallet')), flash[:notice]
    assert_redirected_to :wallets
  end

  test "should not destroy expense does not exist" do
    wallets(:test_10000_dollars).destroy
    assert_no_difference('Wallet.count') do
      get :destroy, wallet_id: 100, confirmed: 1
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.wallet')), flash[:notice]
    assert_redirected_to :wallets
  end

  test "table should contain headers for columns" do
    get :index
    assert_select 'thead th:nth-child(1)', I18n.t('activerecord.attributes.wallet.name')
    assert_select 'thead th:nth-child(2)', I18n.t('activerecord.attributes.wallet.amount')
    assert_select 'thead th:nth-child(3)', I18n.t('activerecord.attributes.wallet.remaining_amount')
    assert_select 'thead th:nth-child(4)', I18n.t('actions')
  end

  test "table should contain information about name and amount" do
    sign_in users(:user_with_wallet_2)
    get :index
    assert_select 'tbody tr:first-child td:nth-child(1)', 'Cars'
    assert_select 'tbody tr:first-child td:nth-child(2)', '$10,000,000.00'
    assert_select 'tbody tr:first-child td:nth-child(3)', '$9,999,800.00'
  end

  test "table should contain delete and edit buttons for desktop" do
    test_that_edit_and_delete_buttons_are_present
  end
end

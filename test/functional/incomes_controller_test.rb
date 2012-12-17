require 'test_helper'
require_relative 'layout_tests'

class IncomesControllerTest < ActionController::TestCase
  include LayoutTests

  def setup
    sign_in users(:user_without_wallet)
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
      sign_out users(:user_without_wallet)
      test_that_guest_will_be_redirect(action)
    end
  end

  test "should get new" do
    get :new 
    assert_response :success
    assert_not_nil assigns(:income)
  end

  test "should contain link to adding new income" do
    get :index
    assert_select 'div.form-actions.hidden-phone a', I18n.t('add_income')
    assert_select 'div.form-actions.visible-phone a', I18n.t('add_income')
  end

  test "income with name 'First' should be on the top of table" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'tbody tr:first-child td:first-child', users(:user_with_wallet_1).families.first.incomes.last.source
  end

  test "table should contain information about source, amount, tax, net profit and also action buttons" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'thead th', I18n.t('activerecord.attributes.income.source')
    assert_select 'thead th', I18n.t('activerecord.attributes.income.amount')
    assert_select 'thead th', I18n.t('activerecord.attributes.income.tax')
    assert_select 'thead th', I18n.t('activerecord.attributes.income.net')
    assert_select 'thead th', I18n.t('actions')
  end

  test "table should contain delete and edit buttons for desktop" do
    sign_in users(:user_with_wallet_1)
    test_that_edit_and_delete_buttons_are_present
  end

  test "should contain pagination" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'div.pagination'
  end

  test "should contain pagination with two pages" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'div.pagination li', count: 4
  end

  test "should not contain pagination" do
    get :index
    assert_select 'div.pagination', count: 0
  end

  test "should generate proper form on new income page" do
    get :new
    assert_select 'form' do
      assert_select 'input#income_source'
      assert_select 'input#income_amount'
      assert_select 'input#income_tax'
      assert_select 'div.percent span', '%'
      assert_select 'a', I18n.t('back.income')
      assert_select 'input[TYPE=submit]'
    end
  end
  
  test "should create income" do
    assert_difference('Income.count') do
      post :create, income: { source: 'source', amount: 200, tax: 23, user_id: 1, execution_date: '2012-11-25' }
    end
    assert_redirected_to incomes_path
    assert_equal I18n.t('flash.success_one', model: I18n.t('activerecord.models.income')), flash[:notice]
  end

  test "should render new if income amount is not valid" do
    post :create, income: { source: 'source', amount: 'zero', tax: 0 }
    assert_template 'new'
  end

  test "should redirect to new income and notify about creation if source and amount are valid" do
    post :create, income: { source: 'source', amount: 200, tax: 0, execution_date: '2012-11-25' }
    assert_redirected_to incomes_path
    assert_equal I18n.t('flash.success_one', model: I18n.t('activerecord.models.income')), flash[:notice]
  end

  test "should render new if income tax is nil" do
    post :create, income: { source: 'source', amount: 200 }
    assert_template 'new'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomes)
  end

  test "should destroy income and redirect to income index" do
    sign_in users(:user_with_wallet_1)
    assert_difference('Income.count', -1) do
      delete :destroy, id: incomes(:income_2).id
    end
    assert_equal  I18n.t('flash.delete_one', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "should not destroy income with belongs to another user" do
    assert_no_difference('Income.count') do
      delete :destroy, id: incomes(:income_1).id
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "should not destroy income does not exist" do
    incomes(:income_2).destroy
    assert_no_difference('Income.count') do
      delete :destroy, id: 1
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "should update income and redirect to income index" do
    sign_in users(:user_with_wallet_1)
    put :update, id: incomes(:income_2), income: {source: 'Prize'}
    assert_equal I18n.t('flash.update_one', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "should not update income with belongs to another user" do
    put :update, id: incomes(:income_2), income: {name: 'New car'}
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "should not update income that not exist" do
    incomes(:income_1).destroy
    put :update, id: 1, income: {amount: 20000}
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.income')), flash[:notice]
    assert_redirected_to :incomes
  end

  test "date input should contain current date by default" do
    get :new
    assert_select 'input#income_execution_date[value=?]', Date.today.strftime("%d.%m.%Y")
  end
end

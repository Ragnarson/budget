require 'test_helper'
require_relative 'layout_tests'

class ExpensesControllerTest < ActionController::TestCase
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
    assert_not_nil assigns(:expense)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expenses)
  end

  test "table should contain information about name, amount, date and also action buttons" do
    get :index
    assert_select 'thead th', I18n.t('activerecord.attributes.expense.name')
    assert_select 'thead th', I18n.t('activerecord.attributes.expense.amount')
    assert_select 'thead th', I18n.t('activerecord.attributes.expense.execution_date')
    assert_select 'thead th', I18n.t('actions')
  end

  test "table should contain delete and edit buttons" do
    get :index
    assert_select 'tbody tr td a', I18n.t('edit')
    assert_select 'tbody tr td a', I18n.t('delete')
  end

  test "should get index with pagination" do
    get :index
    assert_select 'div.pagination'
  end

  test "should get index with pagination when there is no expenses and params[:d] is blank" do
    sign_in users(:user_without_expenses)
    get :index
    assert_select 'div.pagination'
    assert_blank assigns(:expenses)
  end

  test "should get index with pagination when there is no expenses and params[:d] its not blank" do
    get :index, d: '2015-01-01'
    assert_select 'div.pagination'
    assert_blank assigns(:expenses)
  end

  test "pagination should contain name of 3 months" do
    get :index
    assert_select 'div.pagination li', count: 3
    assert_select 'div.pagination li:nth-child(1) a', I18n.l(Date.today-1.month, format: :month_with_year)
    assert_select 'div.pagination li:nth-child(2) a', I18n.l(Date.today, format: :month_with_year)
    assert_select 'div.pagination li:nth-child(3) a', I18n.l(Date.today+1.month, format: :month_with_year)
  end

  test "should redirect to index with notice when given date params is invalid" do
    get :index, d: 'xxx'
    assert_equal I18n.t('flash.invalid_date'), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should get index with information about no expenses" do
    sign_in users(:user_without_expenses)
    get :index
    assert_select 'p', I18n.t('specify.expense')
  end

  test "should contain link to adding new expense" do
    get :index
    assert_select 'div.form-actions.hidden-phone a', I18n.t('add_expense')
    assert_select 'div.form-actions.visible-phone a', I18n.t('add_expense')
  end

  test "form should be visible on add new expense page" do
    get :new
    assert_select 'form' do
      assert_select 'input#expense_name'
      assert_select 'input#expense_amount'
      assert_select 'input#expense_execution_date'
      assert_select 'select#expense_wallet_id'
      assert_select 'input[TYPE=submit]'
      assert_select 'a', I18n.t('back.expenses')
    end
  end

  test "date input should contain current date by default" do
    get :new
    assert_select 'input#expense_execution_date[value=?]', Date.today.strftime("%d.%m.%Y")
  end

  test "wallet select list should contain name and amount of each wallet" do
    get :new
    assert_select 'select#expense_wallet_id option:first-child', "#{wallets(:test_10000_dollars).name} (#{number_to_currency -100000})"
  end

  test "wallet select list should be in correct order based on expenses quantity" do
    sign_in users(:user_with_wallet_3)
    get :new
    assert_select "select#expense_wallet_id option:nth-child(1)[value=?]", wallets(:books_300_dollars).id
    assert_select "select#expense_wallet_id option:nth-child(2)[value=?]", wallets(:home_1500_dollars).id
    assert_select "select#expense_wallet_id option:nth-child(3)[value=?]", wallets(:empty_500_dollars).id
  end

  test "should redirect to new wallet if there are not any wallets in database" do
    sign_in users(:user_without_wallet)
    get :new
    assert_redirected_to :new_wallet
  end

  test "should create expense and redirect to new with notice on valid inputs" do
    post :create, expense: {name: 'A', amount: 500, wallet_id: wallets(:test_10000_dollars).id, execution_date: '2012-11-25'}
    assert_redirected_to :new_expense
    assert_equal I18n.t('flash.success_one', model: I18n.t('activerecord.models.expense')), flash[:notice]
  end

  test "should render new template on invalids inputs" do
    post :create, expense: {name: 'Milk', amount: -100}
    assert_template :new
  end

  test "should destroy expense and redirect to all expenses" do
    assert_difference('Expense.count', -1) do
      delete :destroy, id: expenses(:expense_1).id
    end
    assert_equal I18n.t('flash.delete_one', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should not destroy expense with belongs to another user" do
    assert_no_difference('Expense.count') do
      delete :destroy, id: expenses(:expense_12).id
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should not destroy expense does not exist" do
    expenses(:expense_1).destroy
    assert_no_difference('Expense.count') do
      delete :destroy, id: 1
    end
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should update expense and redirect to all expenses" do
    put :update, id: expenses(:expense_1), expense: {name: 'New car'}
    assert_equal I18n.t('flash.update_one', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should not update expense with belongs to another user" do
    put :update, id: expenses(:expense_12), expense: {name: 'New car'}
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test "should not update expense that does not exist" do
    expenses(:expense_1).destroy
    put :update, id: 1, expense: {name: 'New car'}
    assert_equal I18n.t('flash.no_record', model: I18n.t('activerecord.models.expense')), flash[:notice]
    assert_redirected_to :expenses
  end

  test 'should be link to create new income' do
    sign_in users(:user_without_income)
    get :new
    assert_select 'a', text: I18n.t('add_income')
  end
end

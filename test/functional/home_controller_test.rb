require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def after
    DatabaseCleaner.clean
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_template :about
  end

  test 'should contain hello message and login link' do
    get :index
    assert_select 'h4', 'Welcome to the Budget Application'
    assert_select 'a', 'Login via Google account'
    assert_select 'a', 'Login via Google account'
  end

  test 'should not contain login, incomes, new expense, budgets and members link' do
    get :index
    assert_select 'a', text: 'user_with_wallet_1@budget.shellyapp.com', count: 0
    assert_select 'a', text: 'Incomes', count: 0
    assert_select 'a', text: 'New expense', count: 0
    assert_select 'a', text: 'Budgets', count: 0
    assert_select 'a', text: 'Members', count: 0
  end

  test 'when authenticated should contain login, incomes, new expense, budgets and members links' do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'a', 'user_with_wallet_1@budget.shellyapp.com'
    assert_select 'a', 'Incomes'
    assert_select 'a', 'Expenses'
    assert_select 'a', 'Budgets'
    assert_select 'a', 'Members'
  end

  test "add new expense form should not be visible on home page for guess" do
    get :index
    assert_select 'input#expense_name', count: 0
    assert_select 'input#expense_amount', count: 0
    assert_select 'input#expense_execution_date', count: 0
    assert_select 'select#expense_wallet_id', count: 0
  end 

  test "add new expense form should be visible on home page if user is authenticated" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'form' do
      assert_select 'input#expense_name'
      assert_select 'input#expense_amount'
      assert_select 'input#expense_execution_date'
      assert_select 'select#expense_wallet_id'
    end
  end 

  test 'should be message with actual balance' do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'ul.pull-right' do
      assert_select 'a', 'Balance: 0,00'
    end
  end

  test 'should not be a message with actual balance without logging'  do
    get :index
    assert_select 'a', text: 'Actual balance: 0,00', count: 0
  end
end

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

  test 'should contain hello message and login link' do
    get :index
    assert_select 'h2', 'Welcome to the Budget Application'
    assert_select 'a', 'Login via Google account'
    assert_select 'a', 'Login via Google account'
  end

  test 'should not contain login, home, incomes, expenses and budgets link' do
    get :index
    assert_select 'a', text: 'user1@budget.com', count: 0
    assert_select 'a', text: 'Home', count: 0
    assert_select 'a', text: 'Incomes', count: 0
    assert_select 'a', text: 'Expenses', count: 0
    assert_select 'a', text: 'Budgets', count: 0
  end

  test 'when authenticated should contain login, home, incomes, expenses and budgets links' do
    sign_in users(:user1)
    get :index
    assert_select 'a', 'user1@budget.com'
    assert_select 'a', 'Home'
    assert_select 'a', 'Incomes'
    assert_select 'a', 'Expenses'
    assert_select 'a', 'Budgets'
  end

  test 'should be message with actual balance' do
    sign_in users(:user1)
    get :index
    assert_select 'ul.pull-right' do
      assert_select 'a', 'Actual balance: 0,00'
    end
  end

end

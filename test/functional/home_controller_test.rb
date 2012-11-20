require 'test_helper'
require_relative 'layout_tests'

class HomeControllerTest < ActionController::TestCase
  include LayoutTests

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

  test 'should contain hello message, basic information and login link' do
    get :index
    assert_select 'h4', I18n.t('home.welcome')
    assert_select 'p', I18n.t('home.information')
    assert_select 'a', I18n.t('home.login')
  end

  test 'should not contain login, incomes, expenses, budgets and members link' do
    get :index
    assert_select 'a', text: 'user_with_wallet_1@budget.shellyapp.com', count: 0
    assert_select 'a', text: I18n.t('header.incomes'), count: 0
    assert_select 'a', text: I18n.t('header.expenses'), count: 0
    assert_select 'a', text: I18n.t('header.budgets'), count: 0
    assert_select 'a', text: I18n.t('header.members'), count: 0
  end

  test "add new expense form should not be visible on home page for guess" do
    get :index
    assert_select 'input#expense_name', count: 0
    assert_select 'input#expense_amount', count: 0
    assert_select 'input#expense_execution_date', count: 0
    assert_select 'select#expense_wallet_id', count: 0
  end 

  test "date input should contain current date by default" do
    sign_in users(:user_with_wallet_1)
    get :index
    assert_select 'input#expense_execution_date[value=?]', Date.today.strftime("%d.%m.%Y")
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

  test 'should not be a message with actual balance without logging'  do
    get :index
    assert_select 'a', text: I18n.t('header.balance'), count: 0
  end

  test 'should be link to create new budget' do
    sign_in users(:user_without_wallet)
    get :index
    assert_select 'a', text: I18n.t('add_budget')
  end

  test 'should be link to create new income' do
    sign_in users(:user_without_income)
    get :index
    assert_select 'a', text: I18n.t('add_income')
  end
end

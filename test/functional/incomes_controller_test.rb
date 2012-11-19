require_relative '../test_helper'
require_relative 'layout_tests'

class IncomesControllerTest < ActionController::TestCase
  include LayoutTests

  def setup
    sign_in users(:user_without_wallet)
  end

  def after
    DatabaseCleaner.clean
  end

  test "should get new"do
    get :new 
    assert_response :success
    assert_not_nil assigns(:income)
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
      assert_select 'input[TYPE=submit]'
    end
  end
  
  test "should create income" do
    assert_difference('Income.count') do
      post :create, income: { source: 'source', amount: 200, tax: 23, user_id: 1 }
    end
    assert_redirected_to incomes_path
    assert_equal I18n.t('flash.success_one', model: I18n.t('activerecord.models.income')), flash[:notice]
  end

  test "should render new if income amount is not valid" do
    post :create, income: { source: 'source', amount: 'zero' }
    assert_template 'new'
  end

  test "should redirect to new income and notify about creation if source and amount are valid" do
    post :create, income: { source: 'source', amount: 200 }
    assert_redirected_to incomes_path
    assert_equal I18n.t('flash.success_one', model: I18n.t('activerecord.models.income')), flash[:notice]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomes)
  end

  test "total sum should be zero if array is empty" do
    get :index
    if assert_equal assigns(:incomes).length, 0
      assert_equal assigns(:total), 0
    end
  end
end

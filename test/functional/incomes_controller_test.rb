require 'test_helper'

class IncomesControllerTest < ActionController::TestCase
  def setup
    sign_in users(:user_without_wallet_1)
  end

  def after
    DatabaseCleaner.clean
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
    assert_redirected_to all_incomes_path
    assert_equal 'Income has been successfully created', flash[:notice]
  end

  test "should render new if income amount is not valid" do
    post :create, income: { source: 'source', amount: 'zero' }
    assert_template 'new'
  end

  test "should redirect to new income and notify about creation if source and amount are valid" do
    post :create, income: { source: 'source', amount: 200 }
    assert_redirected_to all_incomes_path
    assert_equal 'Income has been successfully created', flash[:notice]
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomes)
  end
end

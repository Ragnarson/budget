require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    sign_in users(:user1)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:expense)
  end

  test "test form is visible on expense page" do
    get :new
    assert_select 'form' do
      assert_select 'input#expense_name'
      assert_select 'input#expense_amount'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should create expense and redirect to new with notice on valid inputs" do
    post :create, expense: { name: 'My new SSD', amount: 500 }
    expense = Expense.new(@request.params[:expense])
    assert_equal expense.valid?, true
    assert_redirected_to :new_expense
    assert_equal 'Expense was successfully created.', flash[:notice]
  end

  test "should render new template on invalids inputs" do
    post :create, expense: { name: 'Milk', amount: -100 }
    expense = Expense.new(@request.params[:expense])
    assert_equal expense.valid?, false
    assert_template :new
  end
end

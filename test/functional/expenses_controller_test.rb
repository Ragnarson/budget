require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase

  test "should be form on new expense page" do
    get :new
    assert_select 'form' do
      assert_select 'input#expense_name'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "validation should return false on empty name" do
    expense = Expense.new(:name => '')
    assert_equal expense.valid?, false
  end

  test "validation should return false on valid name and not valid amount" do
    expense = Expense.new(:name => 'My new SSD', :amount => -100)
    assert_equal expense.valid?, false
  end

  test "validation should return true on name='My new SSD' and amount=1" do
    expense = Expense.new(:name => 'My new SSD', :amount => 1)
    assert_equal expense.valid?, true
  end

  test "post valid form should redirect and return flash notice" do
    post :create, :expense => { :name => 'New SSD', :amount => 100.50 }
    assert_redirected_to :new_expense
    assert_equal 'Expense was successfully created.', flash[:notice]
  end

  test "post not valid form should render new template" do
    post :create, :expense => { :name => '' }
    assert_template :new
    post :create, :expense => { :name => 'My new SSD', :amount => -1 }
    assert_template :new
  end
end

require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase

  test "test form is visible on expense page" do
    get :new
    assert_select 'form' do
      assert_select 'input#expense_name'
      assert_select 'input#expense_amount'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "recognizes invalid inputs" do
    assert_equal Expense.new.valid?, false
    assert_equal Expense.new(:name => 'My new SSD', :amount => -1).valid?, false
    assert_equal Expense.new(:amount => 10).valid?, false
    assert_equal Expense.new(:name => 'a', :amount => 100.55).valid?, false
    assert_equal Expense.new(:name => 'My new SSD', :amount => 0.111).valid?, false
  end

  test "recognizes valid inputs" do
    assert_equal Expense.new(:name => 'My new SSD', :amount => 1).valid?, true
    assert_equal Expense.new(:name => 'My new SSD', :amount => 10.55).valid?, true
    assert_equal Expense.new(:name => 'Milk', :amount => 3.15).valid?, true
  end

  test "should redirect to new with notice" do
    post :create, :expense => { :name => 'New SSD', :amount => 100.501 }
    assert_redirected_to :new_expense
    assert_equal 'Expense was successfully created.', flash[:notice]
  end

  test "should render new template" do
    post :create, :expense => {}
    assert_template :new
    post :create, :expense => { :name => 'Rt' }
    assert_template :new
    post :create, :expense => { :name => 'My new SSD', :amount => -1 }
    assert_template :new
    post :create, :expense => { :amount => 10.53 }
  end
end

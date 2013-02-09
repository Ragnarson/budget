require 'test_helper'
 
class ExpenseTest < ActiveSupport::TestCase
  def after
    DatabaseCleaner.clean
  end

  private
  def assert_invalid(args)
    assert(wallets(:test_10000_dollars).expenses.build(args).invalid?)
  end

  def assert_valid(args)
    assert(wallets(:test_10000_dollars).expenses.build(args).valid?)
  end

  public
  test "should recognize empty inputs" do
    assert_invalid({})
  end

  test "should recognize empty name" do
    assert_invalid(amount: 100, execution_date: '2012-10-11')
  end

  test "should recognize too long name" do
    assert_invalid(name: 'a'*130, amount: 100, execution_date: '2012-11-11')
  end

  test "should recognize empty amount" do
    assert_invalid(name: 'Netbook', execution_date: '2011-05-21')
  end

  test "should recognize amount less than 0" do
    assert_invalid(name: 'My new SSD', amount: -1, execution_date: '2013-12-09')
  end

  test "should recognize amount equals 0" do
    assert_invalid(name: 'Milk', amount: 0, execution_date: '2011-12-21')
  end

  test "should recognize invalid amount" do
    assert_invalid(name: 'Milk', amount: 0.555, execution_date: '2011-11-11')
  end

  test "should recognize invalid type of amount" do
    assert_invalid(name: 'netbook', amount: 'one', execution_date: '2011-11-11')
  end

  test "should recognize valid inputs" do
    assert_valid(name: 'My new SSD', amount: 1, execution_date: '2011-11-11')
  end

  test "should recognize valid inputs (with valid fraction in amount)" do
    assert_valid(name: 'My new SSD', amount: 10.55, execution_date: '2011-11-11')
  end

  test "should recognize empty wallet_id" do
    assert(Expense.new(name: 'My new SSD', amount: 10000.99, wallet_id: nil, execution_date: '2011-11-11').invalid?)
  end

  test "should recognize invalid type of wallet_id" do
    assert(Expense.new(name: 'Milk', amount: 10, wallet_id: 'abc', execution_date: '2011-11-11').invalid?)
  end

  test "should recognize empty execution_date" do
    assert_invalid(name: 'Milk', amount: 200000)
  end

  test "should recognize invalid type of execution_date" do
    assert_invalid(name: 'Notebook', amount: 3031, execution_date: 100)
  end

  test "should recognize invalid execution_date" do
    assert_invalid(name: 'Notebook', amount: 3000, execution_date: '2001-13-41')
  end

  test "should not save to database expense with invalid inputs" do
    assert_equal Expense.new(name: 'a', amount: 100, execution_date: '2011-11-11').save, false
  end

  test "should save valid expense to database" do
    assert_equal wallets(:test_10000_dollars).expenses.build(name: 'Milk', amount: 3, execution_date: '2012-01-12').save, true
  end

  test "should be marked as done" do
    expense = Expense.create(name: 'Expense', amount: 10, execution_date: Date.yesterday, wallet_id: wallets(:test_10000_dollars).id)
    assert_equal expense.done, true
  end

  test "should not be marked as done" do
    expense = Expense.create(name: 'Expense', amount: 10, execution_date: Date.tomorrow, wallet_id: wallets(:test_10000_dollars).id)
    assert_equal expense.done, false
  end
end

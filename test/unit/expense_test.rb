require 'test_helper'
 
class ExpenseTest < ActiveSupport::TestCase
  test "should recognize empty inputs" do
    assert_equal Expense.new.valid?, false
  end

  test "should recognize empty name" do
    assert_equal Expense.new(amount: 100).valid?, false
  end

  test "should recognize too short name" do
    assert_equal Expense.new(name: 'M', amount: 100).valid?, false
  end

  test "should recognize too long name" do
    assert_equal Expense.new(name: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', amount: 100).valid?, false
  end

  test "should recognize name as array type" do
    assert_equal Expense.new(name: ['aaa', 'bbb'], amount: 100).valid?, false
  end

  test "should recognize empty amount" do
    assert_equal Expense.new(name: 'Netbook').valid?, false
  end

  test "should recognize amount less than 0" do
    assert_equal Expense.new(name: 'My new SSD', amount: -1).valid?, false
  end

  test "should recognize amount equals 0" do
    assert_equal Expense.new(name: 'Milk', amount: 0).valid?, false
  end

  test "should recognize invalid amount" do
    assert_equal Expense.new(name: 'Milk', amount: 0.555).valid?, false
  end

  test "should recognize invalid type of amount" do
    assert_equal Expense.new(name: 'netbook', amount: 'one').valid?, false
  end

  test "should recognize valid inputs" do
    assert_equal Expense.new(name: 'My new SSD', amount: 1).valid?, true
  end

  test "should recognize valid inputs (with valid fraction in amount)" do
    assert_equal Expense.new(name: 'My new SSD', amount: 10.55).valid?, true
  end

  test "should not save to database expense with invalid inputs" do
    assert_equal Expense.new(name: 'a', amount: 100).save, false
  end

  test "should save valid expense to database" do
    assert_equal Expense.new(name: 'Milk', amount: 3).save, true
  end
end

require 'test_helper'

class BalanceTest < ActiveSupport::TestCase

  def setup
    @user = User.new
  end

  test "balance should be euqal zero if there is no income nor expenses" do
    assert_equal Balance.actual(@user), 0
  end

  test "should count actual balance properly when there is no income" do
    @user.expenses.build(amount: 100)
    assert_equal Balance.actual(@user), -100
  end

  test "should count actual balance properly when there are no expenses" do
    @user.incomes.build(amount: 100, tax: 10)
    @user.incomes.build(amount: 100, tax: 0)
    assert_equal Balance.actual(@user), 190
  end

  test "should count actual balance properly" do
    @user.incomes.build(amount: 100)
    @user.incomes.build(amount: 100)
    @user.expenses.build(amount: 100)
    assert_equal Balance.actual(@user), 100
  end

  test "should count actual balance wit tax properly" do
    @user.incomes.build(amount: 100, tax: 10)
    @user.incomes.build(amount: 100, tax: 0)
    @user.expenses.build(amount: 100)
    assert_equal Balance.actual(@user), 90
  end

end

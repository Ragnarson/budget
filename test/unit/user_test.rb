require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = users(:user_with_wallet_1)
  end

  test "should create some username from email" do
    assert_equal @user.username, 'user with wallet 1'
  end

  test "sum should be zero if user doesn't have any incomes" do
    assert_equal User.new.incomes_sum, 0
  end

  test "sum should be equal to amount of lone users income" do
    user = User.new
    user.incomes[0] = Income.new(amount: 20)
    assert_equal user.incomes_sum, 20
  end

  test "sum should be equal to all amounts summed up" do
    user = User.new
    user.incomes[0] = Income.new(amount: 30)
    user.incomes[1] = Income.new(amount: 20)
    assert_equal user.incomes_sum, 50
  end

  test "net profit sum should be zero if user doesn't have any incomes" do
    assert_equal User.new.net_profits_sum, 0
  end

  test "net profit sum should be equal to amount of lone users income" do
    user = User.new
    user.incomes[0] = Income.new(amount: 200, tax: 20)
    assert_equal user.net_profits_sum, 166.67
  end

  test "net profit sum should be equal to all amounts summed up" do
    user = User.new
    user.incomes[0] = Income.new(amount: 100, tax: 10)
    user.incomes[1] = Income.new(amount: 20)
    assert_equal user.net_profits_sum, 110.91
  end

  test "balance should equal 0 up to some date if there is no income nor expenses" do
    @user = User.new
    assert_equal @user.balance_up_to(Date.today), 0
  end

  test "balance should equal 0 up to some date if there is expenses and incomes after this date" do
    @user = users(:user_with_one_income_and_one_expense_in_same_date)
    assert_equal @user.balance_up_to(2.days.ago), 0
  end

  test "should count balance properly up to some date if there is expenses and incomes" do
    @user = users(:user_with_one_income_and_one_expense_in_same_date)
    assert_equal @user.balance_up_to(Date.today), 100
  end

  test "balance should be equal zero if there is no income nor expenses" do
    @user = User.new
    assert_equal @user.balance_actual, 0
  end

  test "should count actual balance properly when there is no income" do
    @user = User.new
    @user.expenses.build(amount: 100)
    assert_equal @user.balance_actual, -100
  end

  test "should count actual balance properly when there are no expenses" do
    @user = User.new
    @user.incomes.build(amount: 100, tax: 10)
    @user.incomes.build(amount: 100, tax: 0)
    assert_equal @user.balance_actual, 190.91
  end

  test "should count actual balance properly" do
    @user = User.new
    @user.incomes.build(amount: 100)
    @user.incomes.build(amount: 100)
    @user.expenses.build(amount: 100)
    assert_equal @user.balance_actual, 100
  end

  test "should count actual balance wit tax properly" do
    @user = User.new
    @user.incomes.build(amount: 100, tax: 10)
    @user.incomes.build(amount: 100, tax: 0)
    @user.expenses.build(amount: 100)
    assert_equal @user.balance_actual, 90.91
  end
end

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
end

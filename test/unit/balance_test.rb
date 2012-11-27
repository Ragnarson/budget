require 'test_helper'

class BalanceTest < ActiveSupport::TestCase

  def setup
    @user = User.new
  end

  test "should count history of operations when there is one income and one expense with two different dates" do
    @user = users(:user_with_wallet_2)
    assert_equal Balance.history(@user, 1, 10 ).length, 4
  end

  test "operation history should be equal zero when there is no expenses and incomes" do
    @user = users(:user_without_incomes_and_expenses)
    assert_equal Balance.history(@user, 1, 10 ).length, 0
  end

  test "should count history of operations when there is one income and one expense in the same date" do
    @user = users(:user_with_one_income_and_one_expense_in_same_date)
    assert_equal Balance.history(@user, 1, 10 ).length, 3
  end
end

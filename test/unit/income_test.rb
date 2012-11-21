require 'test_helper'

class IncomeTest < ActiveSupport::TestCase

  test "should validate income" do
    income = Income.new
    income.source = 1
    income.amount = 200
    income.tax = nil
    income.user_id = 1
    assert(income.valid?)
  end

  test "should save valid income into database" do
    assert_equal Income.new(source: "mother", amount: 200, tax: 23, user_id: users(:user_with_wallet_1).id).save, true
  end

  test "should not save invalid income into database" do
    assert_equal Income.new(source: 1, amount: nil, tax: 23, user_id: users(:user_with_wallet_1).id).save, false
  end

  test "net profit should be properly counted" do
    assert_equal Income.new(source: "mother", amount: 200, tax: 10, user_id: users(:user_with_wallet_1).id).net, 180
  end

  test "should recognize negative tax" do
    assert_equal Income.new(source: "Project X", amount: 1000, tax: -1, user_id: users(:user_with_wallet_1).id).valid?, false
  end 

  test "should recognize tax greater than 99" do
    assert_equal Income.new(source: "Project X", amount: 1000, tax: 100, user_id: users(:user_with_wallet_1).id).valid?, false
  end

  test "should recognize invalid tax type" do
    assert_equal Income.new(source: "Project X", amount: 1000, tax: 'asd', user_id: users(:user_with_wallet_1).id).valid?, false
  end
end

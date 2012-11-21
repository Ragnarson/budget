require 'test_helper'

class IncomeTest < ActiveSupport::TestCase

  def setup
    @user = users(:user_with_wallet_1)
  end

  test "should validate income" do
    assert(@user.incomes.build(source: 1, amount: 200, tax: nil).valid?)
  end

  test "should save valid income into database" do
    assert_equal @user.incomes.build(source: "mother", amount: 200, tax: 23).save, true
  end

  test "should not save invalid income into database" do
    assert_equal @user.incomes.build(source: 1, amount: nil, tax: 23).save, false
  end

  test "net profit should be properly counted" do
    assert_equal @user.incomes.build(source: "mother", amount: 200, tax: 10).net, 180
  end

  test "should recognize negative tax" do
    assert(@user.incomes.build(source: "Project X", amount: 1000, tax: -1).invalid?)
  end 

  test "should recognize tax greater than 99" do
    assert(@user.incomes.build(source: "Project X", amount: 1000, tax: 100).invalid?)
  end

  test "should recognize invalid tax type" do
    assert(@user.incomes.build(source: "Project X", amount: 1000, tax: 'asd').invalid?)
  end
end

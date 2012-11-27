require 'test_helper'

class IncomeTest < ActiveSupport::TestCase

  def setup
    @family = families(:family_of_user_without_wallet)
  end

  test "should validate income" do
    assert(@family.incomes.build(source: 1, amount: 200, tax: 0, execution_date: '2012-11-11').valid?)
  end

  test "should save valid income into database" do
    assert_equal @family.incomes.build(source: "mother", amount: 200, tax: 23, execution_date: '2012-11-11').save, true
  end

  test "should not save invalid income into database" do
    assert_equal @family.incomes.build(source: 1, amount: nil, tax: 23, execution_date: '2012-11-11').save, false
  end

  test "net profit should be properly counted" do
    assert_equal @family.incomes.build(source: "mother", amount: 200, tax: 10).net, 181.82
  end

  test "should recognize negative tax" do
    assert(@family.incomes.build(source: "Project X", amount: 1000, tax: -1).invalid?)
  end

  test "should recognize tax greater than 99" do
    assert(@family.incomes.build(source: "Project X", amount: 1000, tax: 100).invalid?)
  end

  test "should recognize invalid tax type" do
    assert(@family.incomes.build(source: "Project X", amount: 1000, tax: 'asd').invalid?)
  end
end

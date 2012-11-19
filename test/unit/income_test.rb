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
    assert_equal Income.new(source: "mother", amount: 200, tax: 23, user_id: 1).save, true
  end

  test "should not save invalid income into database" do
    assert_equal Income.new(source: 1, amount: nil, tax: 23, user_id: 1).save, false
  end
end

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

end

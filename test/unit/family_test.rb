require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  fixtures :families

  def setup
    @family = families(:family_of_user_without_wallet)
  end

  test "sum should be zero if family doesn't have any incomes" do
    assert_equal Family.new.incomes_sum, 0
  end

  test "sum should be equal to amount of lone family income" do
    family = Family.new
    family.incomes[0] = Income.new(amount: 20)
    assert_equal family.incomes_sum, 20
  end

  test "sum should be equal to all amounts summed up" do
    family = Family.new
    family.incomes[0] = Income.new(amount: 30)
    family.incomes[1] = Income.new(amount: 20)
    assert_equal family.incomes_sum, 50
  end

  test "net profit sum should be zero if family doesn't have any incomes" do
    assert_equal Family.new.net_profits_sum, 0
  end

  test "net profit sum should be equal to amount of lone family income" do
    family = Family.new
    family.incomes[0] = Income.new(amount: 200, tax: 20)
    assert_equal family.net_profits_sum, 166.67
  end

  test "net profit sum should be equal to all amounts summed up" do
    family = Family.new
    family.incomes[0] = Income.new(amount: 100, tax: 10)
    family.incomes[1] = Income.new(amount: 20)
    assert_equal family.net_profits_sum, 110.91
  end
end

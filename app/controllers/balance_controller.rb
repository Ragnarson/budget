class BalanceController < ApplicationController
  def index
    @total_incomes = current_user.incomes_sum
    @total_expenses = current_user.expenses_sum
  end
end

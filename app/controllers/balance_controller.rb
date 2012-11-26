class BalanceController < ApplicationController
  def index
    @total_incomes = current_user.incomes_sum
    @total_expenses = current_user.expenses_sum
    @balances = Balance.history(current_user, params[:page], 5  )
  end
end

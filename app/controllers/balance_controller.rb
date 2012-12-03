class BalanceController < ApplicationController
  before_filter :authenticate_user!

  def index
    @total_incomes = current_user.families.first.incomes_sum
    @total_expenses = current_user.families.first.expenses_sum
    @balances = Balance.history(current_user.families.first, params[:page], 50)
  end
end

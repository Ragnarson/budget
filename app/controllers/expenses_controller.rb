class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def new
    redirect_to new_budget_path, notice: 'First you have to add at least one budget.' if current_user.wallets.empty?
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params[:expense])

    if @expense.save
      redirect_to new_expense_path, notice: 'Expense was successfully created.'
    else
      render action: "new"
    end
  end
end

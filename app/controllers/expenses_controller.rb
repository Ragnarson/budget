class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params[:expense])

    if @expense.valid?
      redirect_to new_expense_path, notice: 'Expense was successfully created.'
    else
      render action: "new"
    end
  end
end

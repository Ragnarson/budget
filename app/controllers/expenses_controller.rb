class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.valid?
        format.html { redirect_to new_expense_path, notice: 'Expense was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


end

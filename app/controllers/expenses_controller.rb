class ExpensesController < ApplicationController
  require 'will_paginate/array'
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
 
  def index
    @expense = Array.new
    current_user.wallets.each do |wallet|
      wallet.expenses.each do |expense|
        @expense.push(expense)
      end
    end
    @expense = @expense.sort!{ |a,b| b.execution_date.to_date <=> a.execution_date.to_date }
    @expense = @expense.paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @expense = Expense.find(params[:id])
    if current_user.wallets.include? Wallet.find(@expense.wallet_id)
      @expense.destroy
      redirect_to all_expenses_path, notice: 'Expense was successfully deleted'
    else
      redirect_to all_expenses_path, notice: "Couldn't find expense"
    end
  end
end

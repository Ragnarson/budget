class ExpensesController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_user!

  def index
    @expenses = current_user.expenses.paginate(page: params[:page], per_page: 10)
  end

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

  def edit
    begin
      @expense = current_user.expenses.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to expenses_path, notice: "Couldn't find expense"
    end
  end

  def update
    begin
      @expense = current_user.expenses.find(params[:id])
      @expense.update_attributes(params[:expense])
      redirect_to expenses_path, notice: 'Expense was successfully updated'
    rescue ActiveRecord::RecordNotFound
      redirect_to expenses_path, notice: "Couldn't find expense"
    end
  end

  def destroy
    begin
      current_user.expenses.find(params[:id]).destroy
      redirect_to expenses_path, notice: 'Expense was successfully deleted'
    rescue ActiveRecord::RecordNotFound
      redirect_to expenses_path, notice: "Couldn't find expense"
    end
  end
end

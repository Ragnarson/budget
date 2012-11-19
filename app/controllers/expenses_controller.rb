class ExpensesController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_user!

  def index
    @expenses = current_user.expenses.order('execution_date DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    redirect_to new_wallet_path, notice: t('flash.add_budget') if current_user.wallets.empty?
    @expense = Expense.new
    @expense.execution_date = Date.today.strftime("%d/%m/%Y")
  end

  def create
    @expense = Expense.new(params[:expense])

    if @expense.save
      redirect_to new_expense_path, notice: t('flash.success_one', model: t('activerecord.models.expense'))
    else
      render action: "new"
    end
  end

  def edit
    @expense = current_user.expenses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def update
    current_user.expenses.find(params[:id]).update_attributes(params[:expense])
    redirect_to expenses_path, notice: t('flash.update_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def destroy
    current_user.expenses.find(params[:id]).destroy
    redirect_to expenses_path, notice: t('flash.delete_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end
end

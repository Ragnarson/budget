class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @expenses = Expense.by_date(current_user.families.first, params[:d])
  end

  def new
    redirect_to new_wallet_path, notice: t('flash.add_wallet') if current_user.families.first.wallets.empty?
    @expense = Expense.new
    date = Date.today.strftime("%d.%m.%Y")
    begin
      date = Date.parse(params[:d]) unless params[:d].blank?
    rescue
    end
    @expense.execution_date = date
  end

  def create
    @expense = Expense.new(params[:expense])
    @expense.family =  current_user.families.first
    @expense.user =  current_user
    if @expense.save
      redirect_to new_expense_path, notice: t('flash.success_one', model: t('activerecord.models.expense'))
    else
      render action: "new"
    end
  end

  def edit
    @expense = current_user.families.first.expenses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def update
    current_user.families.first.expenses.find(params[:id]).update_attributes(params[:expense])
    redirect_to expenses_path, notice: t('flash.update_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def destroy
    current_user.families.first.expenses.find(params[:id]).destroy
    redirect_to expenses_path, notice: t('flash.delete_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end
end

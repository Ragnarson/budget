class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :sanitise_params

  def index
    @expenses = current_user.families.first.expenses_by_date(params[:d])
  end

  def new
    redirect_to new_wallet_path, notice: t('flash.add_wallet') if current_user.families.first.wallets.empty?
    @expense = Expense.new
    date = params[:d].blank? ? Date.today : params[:d]
    @expense.execution_date = date.strftime("%d.%m.%Y")
  end

  def create
    @expense = Expense.new(params[:expense])
    @expense.family = current_user.families.first
    @expense.user = current_user
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
    redirect_to expenses_path(d: params[:expense][:execution_date]), notice: t('flash.update_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def destroy
    current_user.families.first.expenses.find(params[:id]).destroy
    redirect_to expenses_path, notice: t('flash.delete_one', model: t('activerecord.models.expense'))
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  def mark_as_done
    expense = current_user.families.first.expenses.find(params[:expense_id])
    if expense.done
      redirect_to expenses_path, notice: t('flash.expense_already_done')
    else
      expense.update_attributes(execution_date: Date.today)
      redirect_to expenses_path, notice: t('flash.update_one', model: t('activerecord.models.expense'))
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, notice: t('flash.no_record', model: t('activerecord.models.expense'))
  end

  private
  def sanitise_params
    if params[:d]
      begin
        params[:d] = Date.parse(params[:d])
      rescue
        redirect_to expenses_path, notice: t('flash.invalid_date')
      end
    end
  end
end

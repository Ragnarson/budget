class IncomesController < ApplicationController

  def new
    @income = Income.new
  end

  def index
    @incomes = current_user.incomes.order('id DESC').paginate(page: params[:page], per_page: 10)
    @total = current_user.incomes_sum
  end

  def create
    @income = Income.new(params[:income])
    @income.user_id = current_user.id
    if @income.save
      redirect_to incomes_path, notice: t('flash.success_one', model: t('activerecord.models.income'))
    else
      render action: "new"
    end
  end

  def edit
    @income = current_user.incomes.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to incomes_path, notice: t('flash.no_record', model: t('activerecord.models.income'))
  end

  def update
    current_user.incomes.find(params[:id]).update_attributes(params[:income])
    redirect_to incomes_path, notice: t('flash.update_one', model: t('activerecord.models.income'))
  rescue ActiveRecord::RecordNotFound
    redirect_to incomes_path, notice: t('flash.no_record', model: t('activerecord.models.income'))
  end

  def destroy
    current_user.incomes.find(params[:id]).destroy
    redirect_to incomes_path, notice: t('flash.delete_one', model: t('activerecord.models.income'))
  rescue ActiveRecord::RecordNotFound
    redirect_to incomes_path, notice: t('flash.no_record', model: t('activerecord.models.income'))
  end
end

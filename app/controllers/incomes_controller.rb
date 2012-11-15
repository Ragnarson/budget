class IncomesController < ApplicationController

  def new
    @income = Income.new
  end

  def index
    @incomes = current_user.incomes
    @total = current_user.incomes_sum
  end

  def create
    @income = Income.new(params[:income])
    @income.user_id = current_user.id
    if @income.save
      redirect_to all_incomes_path, notice: 'Income has been successfully created'
    else
      render action: "new"
    end
  end
end

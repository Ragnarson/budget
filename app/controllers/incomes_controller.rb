class IncomesController < ApplicationController

  def new
    @income = Income.new
  end

  def index
    @incomes = Income.where user_id: current_user.id
    respond_to do |f|
      f.html # index.html.erb
    end
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

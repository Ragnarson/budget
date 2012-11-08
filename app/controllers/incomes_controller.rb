class IncomesController < ApplicationController

  def new
    @income = Income.new
  end

  def create 
    @income = Income.new(params[:income])
    if @income.save
      redirect_to new_income_path, notice: 'Income has been succesfully created'
    else
      render action: "new"
    end
  end
end

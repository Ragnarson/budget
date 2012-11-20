class HomeController < ApplicationController
  def index
    @expense = Expense.new
    @expense.execution_date = Date.today.strftime("%d.%m.%Y")
  end

  def about
  end
end

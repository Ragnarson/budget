class HomeController < ApplicationController
  def index
    @expense = Expense.new
  end

  def about
  end
end

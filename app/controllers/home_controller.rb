class HomeController < ApplicationController
  def index
    @expense = Expense.new
  end
end

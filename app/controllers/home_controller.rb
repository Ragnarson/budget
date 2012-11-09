class HomeController < ApplicationController
  def index
    @expense = Expense.new
    if current_user
      if current_user.wallets.empty?
        redirect_to new_budget_path, :notice=> "Successfully authenticated! Now please create your first budget."
      end
    end
  end
end

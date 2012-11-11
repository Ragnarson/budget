class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for( resource )
    if current_user.wallets.empty?
      flash[:notice] = 'Authenticated! Please create your first budget.'
      new_budget_path
    else
      flash[:notice] = 'Authenticated! Please add your expenses.'
      new_expense_path
    end
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for( resource )
    msg = "Welcome #{current_user.username.titleize}!"
    if current_user.wallets.empty?
      msg << ' Please create your first budget.'
      path = new_budget_path
    else
      msg << ' Please add your expenses.'
      path = new_expense_path
    end
    flash[:notice] = msg
    path
  end
end

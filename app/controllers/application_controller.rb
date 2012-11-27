class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_actual_balance, :set_locale

  def after_sign_in_path_for(resource)
    if current_user.locale.nil?
      flash[:notice] = t("flash.no_locale")
      edit_profile_path
    else
      I18n.locale = current_user.locale
      new_expense_path
    end
  end

  private

  def set_locale
    if current_user
      I18n.locale = current_user.locale if current_user.locale?  
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  def get_actual_balance
    @actual_balance = current_user.balance_up_to(Date.today) if user_signed_in?
  end
end
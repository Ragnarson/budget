class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :get_actual_balance

  def after_sign_in_path_for(resource)
    new_expense_path
  end

  private

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      cookies[:locale] = params[:locale]
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  def get_actual_balance
    @actual_balance = Balance.actual(current_user) unless !user_signed_in?
  end
end
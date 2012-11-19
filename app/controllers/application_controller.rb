class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :get_actual_balance

  def after_sign_in_path_for(resource)
    root_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  def get_actual_balance
    @actual_balance = Balance.actual_balance(current_user.id) unless !user_signed_in?
  end
end
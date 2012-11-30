class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_actual_balance, :set_locale

  def after_sign_in_path_for(resource)
    if current_user.locale.nil?
      flash[:notice] = t("flash.no_locale")
      edit_profile_path
    else
      new_expense_path
    end
  end

  private

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    elsif current_user.try(:locale)
      I18n.locale = current_user.locale
    else
      I18n.locale = (lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/]
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  def get_actual_balance
    @actual_balance = current_user.families.first.balance_up_to(Date.today) if user_signed_in?
  end
end

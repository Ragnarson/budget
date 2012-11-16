class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def after_sign_in_path_for(resource)
    msg = t('flash.welcome', name: current_user.username.titleize)
    if current_user.wallets.empty?
      msg << t('flash.first_budget')
      path = new_budget_path
    else
      msg << t('flash.add_expense')
      path = new_expense_path
    end
    flash[:notice] = msg
    path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    {:locale => I18n.locale}
  end
end
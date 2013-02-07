class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_actual_balance, :get_actual_balance_ratio, :set_locale
  rescue_from Exception, with: :render_500

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

  def get_actual_balance_ratio
    if user_signed_in?
      if current_user.families.first.expenses.where("execution_date <= ?", Date.today).any?
        sum_of_actual_income = current_user.families.first.net_profits_sum_up_to(Date.today)
        @actual_balance_ratio = @actual_balance / sum_of_actual_income
      else
        @actual_balance_ratio = 1
      end
    end
  end

  def render_500(exception)
    logger.error(exception.message)
    render template: "errors/500", formats: [:html], status: 500
  end
end

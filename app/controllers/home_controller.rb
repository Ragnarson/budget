class HomeController < ApplicationController
  before_filter :set_locale
  #before_filter :authenticate_user!, except: :index

  layout false, only: :index

  def index
    redirect_to new_expense_path if user_signed_in?
  end

  def about
    render "about_" + I18n.locale.to_s
  end

  private

  def set_locale
    if current_user
      I18n.locale = current_user.locale if current_user.locale
    else
      params[:locale] ? I18n.locale = params[:locale] : I18n.locale = (lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/]
    end
  end
end

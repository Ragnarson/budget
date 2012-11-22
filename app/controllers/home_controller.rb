class HomeController < ApplicationController
  before_filter :set_locale
  layout false, only: :index

  def index
    redirect_to new_expense_path if user_signed_in?
  end

  def about
  end

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    elsif cookies[:locale]
      I18n.locale = cookies[:locale]
    else
      I18n.locale = ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    end
  end
end

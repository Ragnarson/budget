class HomeController < ApplicationController
  layout false, only: :index

  def index
    redirect_to new_expense_path if user_signed_in?
  end

  def about
    render "about_" + I18n.locale.to_s
  end
end

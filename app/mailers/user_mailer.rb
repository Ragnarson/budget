class UserMailer < ActionMailer::Base
  default from: "no-reply@shellyapp.com"

  def invite_email(params)
    @user = params[:email]
    @url = params[:url]
    @current_user_email = params[:current_user_email]
    mail(to: @user, subject: "Welcome to Budget application")
  end
end

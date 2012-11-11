class UserMailer < ActionMailer::Base
  default from: "budget.app.ruby@gmail.com"

  def invite_email(user)
    @user = user
    @url = "http://budget.shellyapp.com/"
    mail(:to => user.email, :subject => "Welcome to Budget application")
  end
end

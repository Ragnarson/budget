class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :get_actual_balance, :set_locale

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
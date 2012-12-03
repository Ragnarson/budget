class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :get_actual_balance, :set_locale

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.families.empty?
      if @user.invited_by
        @join_family = FamiliesUsers.find(families_users: {user_id: @user.invited_by})
        @user_family = FamiliesUsers.create(family_id: @join_family.family_id, user_id: @user.id)
        @user_family.save
      else
        @new_family = Family.create()
        @new_family.save
        @user_family = FamiliesUsers.create(family_id: @new_family.id, user_id: @user.id)
        @user_family.save
      end
    end

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

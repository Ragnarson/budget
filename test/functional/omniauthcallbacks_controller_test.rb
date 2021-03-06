require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  def after
    DatabaseCleaner.clean
  end

  def setup
    OmniAuth.config.test_mode = true
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'should redirect to new_user_registration when not authenticated by Google' do
    OmniAuth.config.add_mock(:google_oauth2, info: {})

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]

    get :google_oauth2
    assert_redirected_to :new_user_registration
  end

end

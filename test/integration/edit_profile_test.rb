require 'test_helper'

class EditProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "should change user language" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    click_on('user_menu')
    click_on I18n.t('header.edit_profile', locale: 'pl')
    select('English', from: 'user_locale')
    click_on I18n.t('helpers.submit.update', locale: 'pl')

    assert_equal current_path, '/en/edit'
  end
end

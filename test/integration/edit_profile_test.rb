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

    assert find('ul.nav ul li').has_no_content?(I18n.t('header.edit_profile', locale: 'en'))
    assert find('ul.nav ul li').has_content?(I18n.t('header.edit_profile', locale: 'pl'))
    assert_equal current_path, '/pl/edit'

    select('English', from: 'user_locale')
    click_on I18n.t('helpers.submit.update', locale: 'pl')

    assert find('ul.nav ul li').has_no_content?(I18n.t('header.edit_profile', locale: 'pl'))
    assert find('ul.nav ul li').has_content?(I18n.t('header.edit_profile', locale: 'en'))
    assert_equal current_path, '/en/edit'
  end
end

require 'test_helper'

class BackLinkTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "that back link is working" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl
    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    assert current_path, '/pl/wallets/new'
    click_on I18n.t('back', locale: 'pl')
    assert current_path, '/pl/wallets'
    click_on I18n.t('header.incomes', locale: 'pl')
    assert current_path, '/pl/incomes'
  end
end

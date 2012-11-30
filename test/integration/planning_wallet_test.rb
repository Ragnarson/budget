require 'test_helper'

class PlanningWalletTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "that total amount should be calculated from expense amount" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    click_on I18n.t('plan_wallet', locale: 'pl')

    assert '0', find('#total_amount').text
    find('input.currency').set('100')
    assert '100.00', find('#total_amount').text
  end
end

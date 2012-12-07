require 'test_helper'

class LowBalanceWarningTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_low_balance)
  end

  test "that low balance warning will not be displayed if user balance will be greater than 10%" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    assert page.has_selector?('#actual_balance.warning')

    click_on I18n.t('header.incomes', locale: 'pl')
    click_on I18n.t('add_income', locale: 'pl')
    fill_in('income_source', with: "Payment")
    fill_in('income_amount', with: 1000)
    fill_in('income_tax', with: 0)
    click_on I18n.t('add_income', locale: 'pl')

    assert page.has_no_selector?('#actual_balance.warning')
  end
end

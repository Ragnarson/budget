require 'test_helper'

class BackLinkTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
    allow_google_login_as(@user)
    visit '/pl'
    log_in_pl
  end

  test "that safe back link is working for expenses" do
    click_on I18n.t('header.expenses', locale: 'pl')
    click_on I18n.t('add_expense', locale: 'pl')
    click_on I18n.t('back.expenses', locale: 'pl')
    assert current_path, '/pl/expenses'
  end

  test "that safe back link is working for income" do
    click_on I18n.t('header.incomes', locale: 'pl')
    click_on I18n.t('add_income', locale: 'pl')
    click_on I18n.t('back.income', locale: 'pl')
    assert current_path, '/pl/incomes'
  end

  test "that safe back link is working for wallets" do
    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    click_on I18n.t('back.wallets', locale: 'pl')
    assert current_path, '/pl/wallets'
  end

  test "that safe back link is working for members" do
    click_on I18n.t('header.members', locale: 'pl')
    click_on I18n.t('add_member', locale: 'pl')
    click_on I18n.t('back.members', locale: 'pl')
    assert current_path, '/pl/users'
  end
end

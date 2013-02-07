require 'test_helper'

class PlanningWalletTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "should create wallet with amount" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    
    fill_in 'wallet_name', with: 'Food'
    fill_in 'wallet_amount', with: '200'
    assert_equal '200', find('#wallet_amount input.currency').value
    assert_equal 'Food', find('#wallet_name').value

    click_on I18n.t('add_wallet', locale: 'pl')
    assert current_path, '/pl/wallets'
    assert find('table#wallets').has_content?('Food'), "No 'Food' wallet found"
    assert find('table#wallets').has_content?('200,00'), "Wrong amount of 'Food' wallet"
  end

  test "wallet amount should be calculated from expenses amount" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    click_on I18n.t('plan_wallet', locale: 'pl')
    click_on I18n.t('add_expense', locale: 'pl')
    
    fill_in 'wallet_name', with: 'Girls'
    # First expense
    all(".expense_amount")[0].find("input.currency").set('10,25')
    all(".expense_amount")[0].find(".expense_name input").set('Ewa')
    all(".expense_amount")[0].find(".date_picker input").click
    choose_day(Date.tomorrow)
    # Second expense
    all(".expense_amount")[1].find("input.currency").set('10,25')
    all(".expense_amount")[1].find(".expense_name input").set('Ola')
    all(".expense_amount")[1].find(".date_picker input").click
    choose_day(Date.tomorrow)

    click_on I18n.t('add_wallet', locale: 'pl')

    assert current_path, '/pl/wallets'
    assert find('table#wallets').has_content?('Girls'), "No 'Girls' wallet found"
    assert find('table#wallets').has_content?('20,50'), "Wrong amount of 'Girls' wallet"
  end

  test "wallet should be created without expense" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl

    click_on I18n.t('header.wallets', locale: 'pl')
    click_on I18n.t('add_wallet', locale: 'pl')
    click_on I18n.t('plan_wallet', locale: 'pl')
    
    fill_in 'wallet_name', with: 'Girls'
    find(".expense_amount input.currency").set('10,25')
    find(".remove_fields").click

    click_on I18n.t('add_wallet', locale: 'pl')
    
    assert current_path, '/pl/wallets'
    assert find('table#wallets').has_content?('Girls'), "No 'Girls' wallet found"
    assert find('table#wallets').has_content?('0,00'), "Wrong amount of 'Girls' wallet"
  end
end

require 'test_helper'

class ConfirmDestroyWalletTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_expenses)
    @wallet = get_user_wallet_by_name(@user, "Order")
    @first_expense = @wallet.expenses.find_by_name("AAA")
    @second_expense = @wallet.expenses.find_by_name("BBB")
  end

  test "should directly destroy empty wallet" do
    allow_google_login_as(@user)
    visit '/pl'
    log_in_pl

    wallet = get_user_wallet_by_name(@user, "empty")
    assert_not_nil wallet  
    click_on I18n.t('header.wallets', locale: 'pl')
    find(:xpath, "//a[@href='/pl/wallets/#{wallet.id}/confirm_destroy']").click
    assert_nil get_user_wallet_by_name(@user, "Empty")
  end

  test "should destroy wallet without expenses and assign to them wallet_id=0" do
    goto_wallet_confirm_destroy_page

    click_link I18n.t('delete_only_wallet', locale: 'pl')
    assert_equal Expense.find(@first_expense.id).wallet_id, 0
    assert_equal Expense.find(@second_expense.id).wallet_id, 0
    assert_nil get_user_wallet_by_id(@user, @wallet.id)
  end

  test "should destroy wallet with expenses" do
    goto_wallet_confirm_destroy_page
    
    click_link I18n.t('delete_with_expenses', locale: 'pl')
    assert_nil Expense.find_by_id(@first_expense.id)
    assert_nil Expense.find_by_id(@second_expense.id)
    assert_nil get_user_wallet_by_id(@user, @wallet.id)
  end

  test "should cancel destroying wallet and redirect to the list of wallets" do
    goto_wallet_confirm_destroy_page

    click_link I18n.t('cancel', locale: 'pl')
    assert current_path, "pl/wallets"
  end

  private
  def goto_wallet_confirm_destroy_page
    allow_google_login_as(@user)
    visit '/pl'
    log_in_pl
    click_on I18n.t('header.wallets', locale: 'pl')
    find(:xpath, "//a[@href='/pl/wallets/#{@wallet.id}/confirm_destroy']").click
    assert current_path, "pl/wallets/#{@wallet.id}/confirm_destroy"
  end
end
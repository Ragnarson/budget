require 'test_helper'

class ActionButtonsInIndexTableTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_low_balance)
    allow_google_login_as(@user)
    visit '/pl'
    log_in_pl
  end

  %w(expenses incomes wallets).each do |action|
    test "that edit and delete buttons are present on #{action} index page for" do
      click_on I18n.t("header.#{action}", locale: 'pl')
      assert find(:xpath, '//table/tbody/tr/td/a[@class="action-icon visible-phone"]/img[@src="/assets/edit-icon.png"]')
      assert find(:xpath, '//table/tbody/tr/td/a[@class="action-icon visible-phone"]/img[@src="/assets/delete-icon.png"]')
    end
  end

  test "that delete button is present on users index page" do
    click_on I18n.t('header.members', locale: 'pl')
    assert find(:xpath, '//table/tbody/tr/td/a[@class="action-icon visible-phone"]/img[@src="/assets/delete-icon.png"]')
  end
end

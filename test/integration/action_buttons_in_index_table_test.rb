require 'test_helper'

class ActionButtonsInIndexTableTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_low_balance)
    allow_google_login_as(@user)
    visit '/pl'
    log_in_pl
  end

  test "that edit and delete buttons are present on expenses index page" do
    click_on I18n.t("header.expenses", locale: 'pl')
    assert find(:xpath, '//table/tbody/tr/td/a[@class="btn btn-mini btn-primary"]/i[@class="icon-pencil icon-white"]')
    assert find(:xpath, '//table/tbody/tr/td/a[@class="btn btn-mini btn-danger"]/i[@class="icon-trash icon-white"]')
  end

  %w(incomes wallets).each do |action|
    test "that edit and delete buttons are present on #{action} index page for" do
      click_on I18n.t("header.#{action}", locale: 'pl')
      assert find(:xpath, '//table/tbody/tr/td[@class="visible-phone"]/a[@class="btn btn-primary btn-mini"]/i[@class="icon-pencil icon-white"]')
      assert find(:xpath, '//table/tbody/tr/td[@class="visible-phone"]/a[@class="btn btn-danger btn-mini"]/i[@class="icon-trash icon-white"]')
    end
  end

  test "that delete button is present on users index page" do
    click_on I18n.t('header.members', locale: 'pl')
    assert find(:xpath, '//table/tbody/tr/td/a[@class="btn btn-danger btn-mini visible-phone"]/i[@class="icon-trash icon-white"]')
  end
end

require 'test_helper'

class ExpensesOrderTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_expenses)
  end

  test "that expenses are in proper order" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl
    click_on I18n.t('header.expenses', locale: 'pl')

    find('table.expenses_table thead tr:first-child th:first-child').click()
    assert_equal 'AAA', find('table.expenses_table tbody tr:first-child td:first-child').text
    find('table.expenses_table thead tr:first-child th:first-child').click()
    assert_equal 'BBB', find('table.expenses_table tbody tr:first-child td:first-child').text
    find('table.expenses_table thead tr:first-child th:first-child').click()
    assert_equal 'AAA', find('table.expenses_table tbody tr:first-child td:first-child').text
  end
end

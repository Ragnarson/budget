require 'test_helper'

class MarkExpenseAsDoneTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_expenses)
  end

  test "that expense will be marked as done" do
    allow_google_login_as(@user)
    
    visit '/pl'
    log_in_pl

    click_on I18n.t('header.expenses', locale: 'pl')

    assert find('table.expenses_table').has_content?(I18n.t('mark_as_done', locale: 'pl'))
    assert find('table.expenses_table').has_content?(Date.tomorrow.strftime('%d.%m.%Y')), "table do not have record with tomorrow date"
    assert find('table.expenses_table').has_no_content?(Date.today.strftime('%d.%m.%Y')), "table have record with today date"

    click_on I18n.t('mark_as_done', locale: 'pl')

    assert find('table.expenses_table').has_no_content?(I18n.t('mark_as_done', locale: 'pl')), "table have 'mark as done' button"
    assert find('table.expenses_table').has_no_content?(Date.tomorrow.strftime('%d.%m.%Y')), "table have record with yesterday date"
    assert find('table.expenses_table').has_content?(Date.today.strftime('%d.%m.%Y')), "table do not have record with today date"
  end
end

require 'test_helper'

class DatepickerTest < ActionDispatch::IntegrationTest
  def setup
    @user_pl = users(:user_with_locale_pl)
    @user_en = users(:user_with_locale_en)
  end

  test "should set proper date after picking it with datepicker" do
    allow_google_login_as(@user_pl)

    visit '/pl'
    date_to_click = 1.month.from_now.to_date
    log_in_pl
    click_on_date
    choose_next_month
    choose_day(date_to_click)
    assert_equal date_to_click.to_s, date_value
  end

  test "should open datepicker in proper language on polish sites" do
    allow_google_login_as(@user_pl)

    visit '/pl'
    log_in_pl
    click_on_date
    assert_equal "Pn", first_day_of_the_week
  end

  test "should open datepicker in proper language on english sites" do
    allow_google_login_as(@user_en)

    visit '/en'
    log_in_en
    click_on_date
    assert_equal "Su", first_day_of_the_week
  end
end

require 'test_helper'

class AmountFieldTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "that amount field is clearing after clicking on it" do
    allow_google_login_as(@user)

    visit '/pl'
    log_in_pl
    assert_equal '0,00', find('input.currency').value

    find('input.currency').click()
    assert_equal '', find('input.currency').value
  end
end

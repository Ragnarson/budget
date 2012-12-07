module LayoutTests
  extend ActiveSupport::Testing::Declarative

  private
  def test_that_menu_is_present_on(action)
    sign_in users(:user_with_wallet_1)
    get action
    assert_select 'a', 'user_with_wallet_1@budget.shellyapp.com'
    assert_select 'a', I18n.t('header.incomes')
    assert_select 'a', I18n.t('header.expenses')
    assert_select 'a', I18n.t('header.wallets')
    assert_select 'a', I18n.t('header.members')
    assert_select 'a', I18n.t('header.edit_profile')
    assert_select 'li.visible-phone a', I18n.t('header.logout')
    assert_select 'li.hidden-phone a', I18n.t('header.logout')
  end

  def test_that_should_contain_message_with_actual_balance_on(action)
    sign_in users(:user_with_wallet_2)
    get action
    assert_select 'ul.pull-right' do
      assert_select 'a', "#{I18n.t('header.balance')}: #{number_to_currency(800)}"
    end
  end

  def test_that_footer_should_contain_add_this_buttons(action)
    sign_in users(:user_with_wallet_1)
    get action
    assert_select 'a.addthis_button_facebook_like'
    assert_select 'a.addthis_button_tweet'
    assert_select 'a.addthis_button_pinterest_pinit'
    assert_select 'a.addthis_counter'
    assert_select 'a.addthis_pill_style'
  end

  def test_of_presences_low_balance_warning(action)
    sign_in users(:user_with_low_balance)
    get action
    assert_select 'li#actual_balance.warning', count: 1
  end

  def test_of_not_presences_low_balance_warning(action)
    sign_in users(:user_without_low_balance)
    get action
    assert_select 'li#actual_balance.warning', count: 0
  end

  def test_that_guest_will_be_redirect(action)
    get action
    assert_response 302
  end

end

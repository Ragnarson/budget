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
    get action
    assert_select 'a.addthis_button_facebook_like'
    assert_select 'a.addthis_button_tweet'
    assert_select 'a.addthis_button_pinterest_pinit'
    assert_select 'a.addthis_counter'
  end

end

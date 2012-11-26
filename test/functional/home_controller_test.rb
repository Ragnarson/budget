require 'test_helper'
require_relative 'layout_tests'

class HomeControllerTest < ActionController::TestCase
  include LayoutTests

  def after
    DatabaseCleaner.clean
  end

  test "should contain footer and add this buttons for about" do
    test_that_footer_should_contain_add_this_buttons('about')
  end

  test "when authenticated should contain login, incomes, expenses, wallets and members links for about" do
    test_that_menu_is_present_on('about')
  end

  test "should be message with actual balance for about" do
    test_that_should_contain_message_with_actual_balance_on('about')
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
  end

  test 'should get about' do
    sign_in users(:user_with_wallet_2)
    get :about
    assert_response :success
    assert_template :about
  end

  test 'should render polish about page if locale is pl' do
    sign_in users(:user_with_wallet_2)
    I18n.locale = "pl"
    get :about
    assert_template :about_pl
  end

  test 'should render english about page if locale is en' do
    sign_in users(:user_with_wallet_2)
    I18n.locale = "en"
    get :about
    assert_template :about_en
  end

  test 'should contain hello message, basic information and login link' do
    get :index
    assert_select 'h4', I18n.t('home.welcome')
    assert_select 'p', I18n.t('home.information')
    assert_select 'a', I18n.t('home.login')
  end

  test 'should not contain login, incomes, expenses, wallets and members link' do
    get :index
    assert_select 'a', text: 'user_with_wallet_1@budget.shellyapp.com', count: 0
    assert_select 'a', text: I18n.t('header.incomes'), count: 0
    assert_select 'a', text: I18n.t('header.expenses'), count: 0
    assert_select 'a', text: I18n.t('header.wallets'), count: 0
    assert_select 'a', text: I18n.t('header.members'), count: 0
  end

  test 'should contain link to change language to Polish' do
    I18n.locale = "en"
    get :index
    assert_select "a[href=/pl]"
  end

  test 'should contain link to change language to English' do
    I18n.locale = "pl"
    get :index
    assert_select "a[href=/en]"
  end

  test 'after login should be Polish language' do
    sign_in users(:user_with_locale_pl)
    get :index
    assert_equal :pl, I18n.locale
  end

  test 'after login should be English language' do
    sign_in users(:user_with_locale_en)
    get :index
    assert_equal :en, I18n.locale
  end

end

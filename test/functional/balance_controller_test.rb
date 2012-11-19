require 'test_helper'
require_relative 'layout_tests'

class BalanceControllerTest < ActionController::TestCase
  include LayoutTests

  def setup
    sign_in users(:user_with_wallet_2)
  end

  def after
    DatabaseCleaner.clean
  end

  test 'should be message with actual balance on balance view' do
    get :index
    assert_select 'p', "#{I18n.t('header.balance')}: #{number_to_currency(800)}"
  end

  test 'should be message with sum of incomes on balance view' do
    get :index
    assert_select 'p', "#{I18n.t('total_income')}: #{number_to_currency(1000)}"
  end

  test 'should be message with sum of expenses on balance view' do
    get :index
    assert_select 'p', "#{I18n.t('total_amount')}: #{number_to_currency(200)}"
  end

end

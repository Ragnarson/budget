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

  %w(index).each do |action|
    test "when authenticated should contain login, incomes, expenses, wallets and members links for #{action}" do
      test_that_menu_is_present_on(action)
    end
    test "should be message with actual balance for #{action}" do
      test_that_should_contain_message_with_actual_balance_on(action)
    end
    test "should contain footer and this button for #{action}" do
      test_that_footer_should_contain_add_this_buttons(action)
    end
    test "should contain warning about low balance for #{action}" do
      test_of_presences_low_balance_warning(action)
    end
    test "should not contain warning about low balance for #{action}" do
      test_of_not_presences_low_balance_warning(action)
    end
    test "guest should be redirected for #{action}" do
      sign_out users(:user_with_wallet_2)
      test_that_guest_will_be_redirect(action)
    end
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
    assert_select 'p', "#{I18n.t('total_amount')}: #{number_to_currency(300)}"
  end

  test 'should contain expense' do
    get :index
    assert_select 'tr.expense td.amount', "-#{number_to_currency(200)}"
  end

  test 'should contain income' do
    get :index
    assert_select 'tr.income td.amount', "#{number_to_currency(1000)}"
  end

  test 'should contain day balance' do
    get :index
    assert_select 'tr.balance td.amount', "-#{number_to_currency(200)}"
  end

  test "table should contain tr with warning class for not done expense" do
    get :index
    assert_select 'tr.expense.warning', count: 1
  end
end

#encoding: utf-8
require 'test_helper'

class TablesorterTest < ActionDispatch::IntegrationTest
  def setup
    @user_pl = users(:user_with_locale_pl)
    @user_en = users(:user_with_locale_en)
  end

  test "should sort expenses by name" do
    allow_google_login_as(@user_pl)
    visit '/pl'
    log_in_pl
    click_on I18n.t('header.expenses', locale: 'pl')

    expenses_asc = [
      'audi Q11',
      'Bułka',
      'bułki',
      'szlafrok',
      'śniadanie'
    ]

    # DESC ORDER
    expenses_table_sort_by 1
    expenses_table_check_order 1, expenses_asc

    # ASC ORDER
    expenses_table_sort_by 1
    expenses_table_check_order 1, expenses_asc.reverse
  end

  test "should sort expenses by amount in pl format" do
    allow_google_login_as(@user_pl)
    visit '/pl'
    log_in_pl
    click_on I18n.t('header.expenses', locale: 'pl')

    expenses_amounts_asc = [
      '1,01 zł',
      '1,12 zł',
      '12,00 zł',
      '12,40 zł',
      '12 000 121,12 zł'
    ]

    # ASC ORDER
    expenses_table_sort_by 2
    expenses_table_check_order 2, expenses_amounts_asc

    # DESC ORDER
    expenses_table_sort_by 2
    expenses_table_check_order 2, expenses_amounts_asc.reverse
  end

  test "should sort expenses by amount in en format" do
    allow_google_login_as(@user_en)
    visit '/en'
    log_in_en
    click_on I18n.t('header.expenses', locale: 'en')

    expenses_amounts_asc = [
      '$1.01',
      '$1.12',
      '$12.00',
      '$12.40',
      '$12,000,121.12'
    ]

    # ASC ORDER
    expenses_table_sort_by 2
    expenses_table_check_order 2, expenses_amounts_asc

    # DESC ORDER
    expenses_table_sort_by 2
    expenses_table_check_order 2, expenses_amounts_asc.reverse
  end

  private
  def expenses_table_sort_by(column_number)
    find(:xpath, "//table[@id='expenses_table']/thead/tr[1]/th[#{column_number}]").click()
  end

  def expenses_table_check_order(column_number, array)
    array.each do |e|
      assert_equal e, find(:xpath, "//table[@id='expenses_table']/tbody/tr[#{array.index(e)+1}]/td[#{column_number}]").text
    end
  end
end
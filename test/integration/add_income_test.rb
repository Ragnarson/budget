# -*- coding: utf-8 -*-
require 'test_helper'

class AddIncomeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_with_locale_pl)
  end

  test "should add proper first income to incomes index" do
    allow_google_login_as(@user)
    
    visit '/pl'
    log_in_pl
    click_link("Przychody")
    click_link("dodaj przychód")
    fill_in('income_source', with: "source")
    fill_in('income_amount', with: 1000)
    fill_in('income_tax', with: 0)
    find('.form-actions input').click

    assert_equal find('tbody tr td').text, "source"
    assert_equal find('tbody tr td:nth-child(2)').text, "1 000,00 zł"
    assert_equal find('tbody tr td:nth-child(3)').text, "0%"
    assert_equal find('tbody tr td:nth-child(4)').text, "1 000,00 zł"
    assert_equal find('tbody tr td:nth-child(5)').text, Time.now.strftime("%d.%m.%Y")

  end
end

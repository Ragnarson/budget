module DatepickerTestHelper

  private
  def click_on_date
    find('#expense_execution_date').click
  end

  def choose_next_month
    find('.ui-datepicker-next').click
  end

  def choose_day(date)
    find(".ui-state-default:contains('#{date.day}')").click
  end

  def date_value
    find('#expense_execution_date').value
  end

  def first_day_of_the_week
    find('.ui-datepicker-calendar thead tr th span').text    
  end
end
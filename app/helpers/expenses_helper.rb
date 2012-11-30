module ExpensesHelper
  def date_pagination(date)
    date = Date.today if date.blank?
    content = "<div class='pagination'><ul>"
    [date-1.month, date, date+1.month].each do |d|
      css = (d == date ?  " class='current'" : nil)
      content << "<li#{css}>#{link_to l(d, format: :month_with_year), expenses_path(d: d.at_beginning_of_month)}</li>"
    end
    content << '</ul></div>'
    raw(content)
  end
end

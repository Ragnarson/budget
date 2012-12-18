module ExpensesHelper
  def date_pagination(date)
    date = Date.today if date.blank? 
    content = "<div class='pagination hidden-phone'><ul>"
    add_pagination_logic(content, date)
    content << '</ul></div>'
    
    content << "<div class='pagination pagination-mini pagination-centered visible-phone'><ul>"
    add_pagination_logic(content, date)
    content << '</ul></div>'
    
    raw(content)
  end

  private
  def add_pagination_logic(content, date)
    [date-1.month, date, date+1.month].each do |d|
      css = (d == date ?  " class='current'" : nil)
      content << "<li#{css}>#{link_to l(d, format: :month_with_year), expenses_path(d: d.at_beginning_of_month)}</li>"
    end
  end
end

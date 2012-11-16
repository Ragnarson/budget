module ApplicationHelper
  def time_ago_in_words(date, prefix='')
    if date.future?
      content = l(date)
    else
      content = super(date) +' '+ t(:ago)
      content = "<span class='time-ago'>#{prefix} #{content}</span>" unless prefix.blank?
    end
    raw(content)
  end
end

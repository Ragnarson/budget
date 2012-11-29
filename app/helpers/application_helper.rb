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

  def url_for(options = nil)
    if options == :back
      controller.request.env["HTTP_REFERER"]
    else
      super
    end
  end
end

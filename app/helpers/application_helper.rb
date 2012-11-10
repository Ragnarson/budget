module ApplicationHelper

  def amount_input(form)
    custom = form.input :amount, :wrapper => :prepend do
      content_tag(:span, '$', :class => 'add-on')
       form.input_field(:amount, :to => :currency, :style => 'margin-left: -5px;' 'max-width: 185px')
    end
    raw(custom)
  end

end

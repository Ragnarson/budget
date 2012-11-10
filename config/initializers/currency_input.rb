class CurrencyInput < SimpleForm::Inputs::Base
  def input
    content = "<span class='add-on'>$</span>"
    content << @builder.text_field(attribute_name, input_html_options)
    content.html_safe
  end
end
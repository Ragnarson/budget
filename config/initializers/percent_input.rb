class PercentInput < SimpleForm::Inputs::Base
  def input
    content = ""
    content << @builder.text_field(attribute_name, input_html_options)
    content << "<span class='add-on'>%</span>"
    content.html_safe
  end
end

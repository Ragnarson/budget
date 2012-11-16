class CurrencyInput < SimpleForm::Inputs::Base
  def input
    content = ""
    content << @builder.text_field(attribute_name, input_html_options)
    content << "<span class='add-on'>#{I18n.t('number.currency.format.full_unit')}</span>"
    content.html_safe
  end
end
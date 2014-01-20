class DatepickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag :div, :class => 'input-group' do
      value = object.send(attribute_name)
      date_field = @builder.text_field(attribute_name, input_html_options.merge(:class => 'col-md-4 date_picker form-control', :value => value.try(:to_date)))
      span = template.content_tag :span, '', class: 'input-group-addon' do 
        template.content_tag :i, '', class: 'fa fa-calendar fa-fw'
      end
      date_field += span
    end
  end
end

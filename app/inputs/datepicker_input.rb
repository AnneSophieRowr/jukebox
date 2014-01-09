class DatepickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag :div, :class => 'input-group' do
      value = object.send(attribute_name)
      date_field = @builder.text_field(attribute_name, input_html_options.merge(:class => 'col-md-4 date_picker form-control', disabled: (:disabled unless object.bought), :value => value.try(:to_date)))
      date_field += template.content_tag :span, '', :class => 'input-group-addon glyphicon glyphicon-calendar'
    end
  end
end

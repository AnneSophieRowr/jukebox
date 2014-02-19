class DatetimepickerInput < SimpleForm::Inputs::Base
  
  def input
      value = input_html_options[:value].nil? ? object.send(attribute_name) : input_html_options[:value]
      date = template.content_tag :div, class: 'col-xs-7 input-group pull-left datepicker' do
        field = @builder.text_field(attribute_name, input_html_options.merge(class: 'date_picker form-control', value: value.try(:to_date)))
        field += template.content_tag :span, '', class: 'input-group-addon' do 
          template.content_tag :i, '', class: 'fa fa-calendar fa-fw'
        end
      end
      time = template.content_tag :div, class: 'col-xs-4 input-group timepicker' do
        field = @builder.text_field(attribute_name.to_s.gsub('date', 'time'), input_html_options.merge(class: 'form-control', value: value.try(:strftime, '%H:%M')))
        field += template.content_tag :span, '', class: 'input-group-addon' do 
          template.content_tag :i, '', class: 'fa fa-clock-o fa-fw'
        end
      end

      return date + time

      end
    end

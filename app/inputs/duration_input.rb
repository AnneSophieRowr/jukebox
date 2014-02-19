class DurationInput < SimpleForm::Inputs::Base
  
  def input
    value = object.send(attribute_name) 
    value = value.nil? ? '01/01/70 00:03:30' : Time.at(value).gmtime.strftime('%d/%m/%y %H:%M:%S') 
    template.content_tag :div, class: 'input-group', id: 'pick_duration' do
      field = @builder.text_field(attribute_name, input_html_options.merge(class: 'form-control', 'data-format' => 'mm:ss', 'data-defaultDate' =>  value, 'data-pickDate' => false, 'data-useHours' => false, 'data-useMinutes' => true, 'data-useSeconds' => true, 'data-minuteStepping' => 1 ))
      field += template.content_tag :span, '', class: 'input-group-addon' do 
        template.content_tag :i, '', class: 'fa fa-clock-o fa-fw'
      end
    end
  end

end

module StatsHelper

  def dates_inputs
    dates_inputs = ''
    {start: Date.today.strftime('01/01/%Y'), end: Date.today}.each do |k, v|
      dates_inputs << content_tag(:div, class: 'col-lg-3') do
        content_tag(:form, class: 'simple_form form-horizontal') do
          content_tag(:div, class: 'form-group') do 
            content_tag(:label, class: 'col-lg-3 control-label') do
              I18n.t("helpers.words.#{k}").html_safe
            end +
            content_tag(:div, class: 'input-group datetime') do
              text_field_tag("#{k}_date", v, class: 'form-control') +
              content_tag(:span, class: 'input-group-addon') do
                content_tag(:i, '', class: 'fa fa-calendar')
              end
            end
          end
        end
      end
    end

    return dates_inputs.html_safe
  end

  def stats_inputs(type, *args)
    inputs = ''
    args.each_with_index do |stat, idx|
      klass = idx == 0 ? 'btn btn-default btn-sm active' : 'btn btn-default btn-sm'
      inputs << content_tag(:label, class: klass) do 
        radio_button_tag(stat, '', true, url: chart_data_records_path(stat: stat, type: type)) +
        I18n.t("records.#{stat}")
      end
    end
    content_tag(:div, class: 'col-lg-6') do
      content_tag(:div, class: 'btn-group-sm stats', 'data-toggle' => 'buttons') do
        inputs.html_safe
      end
    end
  end

end

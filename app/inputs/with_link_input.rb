class WithLinkInput < SimpleForm::Inputs::CollectionSelectInput
  def input_html_classes
    super.push('form-control')
  end

  def input
    path = "/#{attribute_name.to_s.gsub(/_id(.*)/, '')}s/new"
    new_link = template.content_tag :a, href: path, class: 'btn btn-default input-group-btn' do
      template.content_tag :span, '', class: 'fa fa-plus'
    end
    template.content_tag :div, class: 'input-group' do
      super << new_link
    end
  end
end

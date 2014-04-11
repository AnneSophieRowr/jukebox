class FileInput < SimpleForm::Inputs::FileInput
  def input
    if object.send(attribute_name).url.nil? or object.send(attribute_name).url.include? 'default.jpg'
      super
    else
      p = template.content_tag :p, File.basename(object.send(attribute_name).url)
      super << p
    end
  end
end

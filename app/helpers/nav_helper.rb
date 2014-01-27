module NavHelper

  def menu_link(resource, controller)
    content_tag(:li, link_to(I18n.t("model.#{resource}"), send("#{resource}_path")), class: ('active' if resource == controller)).html_safe
  end

end

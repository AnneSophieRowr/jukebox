class PlaylistDecorator < Draper::Decorator
  delegate_all

  def kinds
    object.kinds.collect {|k| h.link_to k.name, h.edit_kind_path(k) }.join(', ').html_safe
  end

  def types
    object.types.collect {|t| h.link_to t.name, h.edit_type_path(t) }.join(', ').html_safe
  end

  def types_view
    object.types.collect {|t| t.name}.join(', ')
  end

  def user
    h.link_to(object.user.decorate.name, h.edit_user_path(object.user)).html_safe
  end

  def published
    object.published ? I18n.t('helpers.words.yeslabel') : I18n.t('helpers.words.nolabel')
  end
end

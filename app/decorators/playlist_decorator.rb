class PlaylistDecorator < Draper::Decorator
  delegate_all

  def kinds_name
    object.kinds.collect {|k| h.link_to(k.name, h.edit_kind_path(k))}.join(', ').html_safe
  end

end

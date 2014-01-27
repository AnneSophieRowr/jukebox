class SongDecorator < Draper::Decorator
  delegate_all

  def artist
    h.link_to object.artist.name.capitalize, h.edit_artist_path(object.artist) unless object.artist.nil?
  end

  def albums
    object.albums.collect {|a| h.link_to a.name.capitalize, h.edit_album_path(a)}.join(', ').html_safe
  end

  def albums_view
    object.albums.collect {|a| a.name.capitalize}.join(', ')
  end

  def user
    h.link_to object.user.decorate.name.capitalize, h.edit_user_path(object.user) unless object.user.nil?
  end

end

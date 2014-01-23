class SongDecorator < Draper::Decorator
  delegate_all

  def artist
    h.link_to object.artist.name.capitalize, h.edit_artist_path(object.artist) unless object.artist.nil?
  end

  def albums
    object.albums.collect {|a| h.link_to a.name.capitalize, h.edit_album_path(a)}.join(', ').html_safe
  end

end

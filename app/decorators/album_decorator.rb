class AlbumDecorator < Draper::Decorator
  delegate_all

  def artist
    h.link_to object.artist.name, h.edit_artist_path(object.artist) unless object.artist.nil?
  end

end

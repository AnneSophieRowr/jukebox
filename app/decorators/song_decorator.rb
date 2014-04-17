class SongDecorator < Draper::Decorator
  delegate_all

  def artist
    h.link_to object.artist.name, h.edit_artist_path(object.artist) unless object.artist.nil?
  end

  def albums
    object.albums.collect {|a| h.link_to a.name, h.edit_album_path(a)}.join(', ').html_safe
  end

  def albums_view
    object.albums.collect {|a| a.name}.join(', ')
  end

  def user
    h.link_to object.user.decorate.name, h.edit_user_path(object.user) unless object.user.nil?
  end

  def duration
    Time.at(object.duration).gmtime.strftime('%M:%S') unless object.duration.nil?
  end

end

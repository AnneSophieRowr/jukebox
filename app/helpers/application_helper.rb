module ApplicationHelper

  def kinds
   Kind.all.collect {|c| [c.name.capitalize, c.id]}
  end

  def playlists
    Playlist.all.collect {|c| [c.name.capitalize, c.id]}
  end

  def albums
    Album.all.collect {|c| [c.name.capitalize, c.id]}
  end

  def songs
    Song.all.collect {|c| [c.name.capitalize, c.id]}
  end

  def artists
    Artist.all.collect {|c| [c.name.capitalize, c.id]}
  end

  def play_format(song)
    {title: song.name, artist: song.artist, mp3: song.file.url, poster: song.image.url}.to_json 
  end

end

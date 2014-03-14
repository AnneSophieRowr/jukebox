class Synchronizer

  def self.data(date)
    data = {}
    [Song, Playlist, PlaylistsSong, Kind, KindsPlaylist, Type, PlaylistsType, Album, AlbumsSong, Artist].each do |model|
      data[model.to_s.underscore.pluralize.capitalize] = model.updated(date) unless model.updated(date).empty?
    end
    data['keys'] = data.keys.collect {|k| k.capitalize} unless data.empty?
    return data
  end

end

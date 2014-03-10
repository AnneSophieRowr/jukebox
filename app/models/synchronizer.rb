class Synchronizer

  def self.data(date)
    data = {}
    [Song, Playlist].each do |model|
      data[model.to_s.underscore.pluralize] = model.updated(date)
    end
    return data
  end

end

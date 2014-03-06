class Synchronizer

  def self.data(date)

    data = {}
    [Song, Playlist].each do |model|
      data[model] = model.updated(date)
    end
    return data

  end

end

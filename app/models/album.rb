class Album < ActiveRecord::Base
  include Searchable
  include Synchronizable

  mount_uploader :image, ImageUploader

  has_many :albums_songs, order: :position, dependent: :destroy
  has_many :songs, through: :albums_songs

  belongs_to :artist

  validates_presence_of :name

  def add_song(song_id)
    as = AlbumsSong.new(album_id: self.id, song_id: song_id)
    as.save!
  end

  def details
    a = self.decorate
    details = "#{songs.count} titre(s)"
    details = "#{a.artist} - #{details}" unless a.artist.nil?
    return details
  end

end

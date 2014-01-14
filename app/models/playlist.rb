class Playlist < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :kind
  belongs_to :user
  has_many :playlists_songs, order: :position
  has_many :songs, through: :playlists_songs


  def add_song(song_id)
    p = PlaylistsSong.new(playlist_id: self.id, song_id: song_id)
    p.save!
  end

end

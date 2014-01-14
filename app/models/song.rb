class Song < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  has_and_belongs_to_many :playlists
  belongs_to :user
  has_many :playlists_songs, order: :position
  has_many :playlists, through: :playlists_songs

  validates_presence_of :file, :name

end

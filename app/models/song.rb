class Song < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  has_and_belongs_to_many :playlists
  belongs_to :user
end

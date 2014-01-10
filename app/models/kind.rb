class Kind < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :playlists
end

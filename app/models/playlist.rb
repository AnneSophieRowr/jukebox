class Playlist < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :kind
  belongs_to :user

end

class Artist < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :songs

  validates_presence_of :name

end

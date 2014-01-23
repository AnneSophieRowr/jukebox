class Artist < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :songs
  has_many :albums

  validates_presence_of :name

end

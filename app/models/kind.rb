class Kind < ActiveRecord::Base
  include Synchronizable

  mount_uploader :image, ImageUploader

  has_many :kinds_playlists
  has_many :playlists, :through => :kinds_playlists

  validates_presence_of :name
end

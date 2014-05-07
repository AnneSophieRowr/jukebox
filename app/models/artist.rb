class Artist < ActiveRecord::Base
  include Searchable
  include Synchronizable

  mount_uploader :image, ImageUploader
  has_many :songs
  has_many :albums

  validates_presence_of :name

  def details
    ["#{songs.count} titre(s)", description].reject(&:blank?).join(' - ')
  end

end

class Artist < ActiveRecord::Base
  include Searchable

  mount_uploader :image, ImageUploader
  has_many :songs
  has_many :albums

  validates_presence_of :name

  def details
    a = self.decorate
    details = "#{a.songs.count} titre(s)"
    details = "#{a.description} - #{details}" unless description.empty?
    return details
  end

end

class Type < ActiveRecord::Base
  include Synchronizable

  validates :name, uniqueness: true, presence: true

  has_many :playlists_types, dependent: :destroy
  has_many :playlists, through: :playlists_types
end

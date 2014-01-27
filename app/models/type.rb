class Type < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :playlists_types, dependent: :destroy
  has_many :playlists, through: :playlists_types
end

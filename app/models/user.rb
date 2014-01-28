class User < ActiveRecord::Base
  devise :database_authenticatable
  default_scope { order('last_name') }
  has_many :playlists
  has_many :songs

  validates_presence_of :last_name, :first_name, :email, :password, :password_confirmation
end

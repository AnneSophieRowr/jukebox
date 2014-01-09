class User < ActiveRecord::Base
  devise :database_authenticatable
  default_scope { order('last_name') }
  has_many :playlists
end

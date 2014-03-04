class KindsPlaylist < ActiveRecord::Base
  include Synchronizable

  belongs_to :playlist
  belongs_to :kind

end

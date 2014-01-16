class KindsPlaylist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :kind

end

class PlaylistsType < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :type
end

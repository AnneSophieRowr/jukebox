class PlaylistsType < ActiveRecord::Base
  include Synchronizable

  belongs_to :playlist
  belongs_to :type
end

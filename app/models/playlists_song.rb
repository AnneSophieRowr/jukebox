class PlaylistsSong < ActiveRecord::Base
  include Synchronizable

  belongs_to :playlist
  belongs_to :song

  acts_as_list scope: :playlist

  default_scope { order('position') }

end

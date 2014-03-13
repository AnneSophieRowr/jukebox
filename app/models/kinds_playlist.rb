class KindsPlaylist < ActiveRecord::Base
  include Synchronizable

  belongs_to :playlist, touch: true
  belongs_to :kind, touch: true

end

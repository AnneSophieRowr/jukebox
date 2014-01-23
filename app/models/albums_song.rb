class AlbumsSong < ActiveRecord::Base
  belongs_to :album
  belongs_to :song

  acts_as_list scope: :album

  default_scope { order('position') }

end

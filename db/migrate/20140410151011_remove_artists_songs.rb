class RemoveArtistsSongs < ActiveRecord::Migration
  def change
    drop_table :artists_songs
  end
end

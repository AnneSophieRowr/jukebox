class RemoveAlbumOfSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :album
  end
end

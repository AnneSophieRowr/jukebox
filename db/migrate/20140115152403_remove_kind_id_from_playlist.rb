class RemoveKindIdFromPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :kind_id
  end
end

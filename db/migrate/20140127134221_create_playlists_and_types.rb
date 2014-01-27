class CreatePlaylistsAndTypes < ActiveRecord::Migration
  def change
    create_table :playlists_types do |t|
      t.belongs_to :playlist
      t.belongs_to :type
    end
  end
end

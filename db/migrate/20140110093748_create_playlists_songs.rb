class CreatePlaylistsSongs < ActiveRecord::Migration
  def change
    create_table :playlists_songs do |t|
      t.belongs_to :playlist
      t.belongs_to :song
    end
  end
end

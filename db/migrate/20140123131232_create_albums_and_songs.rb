class CreateAlbumsAndSongs < ActiveRecord::Migration
  def change
    create_table :albums_songs do |t|
      t.belongs_to :album
      t.belongs_to :song
      t.integer    :position
    end
  end
end

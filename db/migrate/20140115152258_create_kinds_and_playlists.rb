class CreateKindsAndPlaylists < ActiveRecord::Migration
  def change
    create_table :kinds_playlists do |t|
      t.belongs_to :kind
      t.belongs_to :playlist
    end
  end
end

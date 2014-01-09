class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string  :name,      :null => false
      t.string  :image
      t.integer :kind_id,   :null => false
      t.integer :user_id,   :null => false

      t.timestamps
    end
  end
end

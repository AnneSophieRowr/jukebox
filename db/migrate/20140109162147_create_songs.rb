class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string  :name,      :null => false
      t.string  :image
      t.string  :file
      t.string  :artist 
      t.string  :album
      t.integer :duration
      t.integer :user_id,   :null => false

      t.timestamps
    end
  end
end

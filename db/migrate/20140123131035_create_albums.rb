class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string    :name,        null: false
      t.string    :image
      t.integer   :year
      t.integer   :artist_id
      t.integer   :user_id,     null: false

      t.timestamps
    end
  end
end

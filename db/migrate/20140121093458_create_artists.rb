class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string  :name,        null: false
      t.string  :image
      t.text    :description
    end
  end
end

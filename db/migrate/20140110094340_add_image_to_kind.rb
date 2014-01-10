class AddImageToKind < ActiveRecord::Migration
  def change
    add_column :kinds, :image, :string
  end
end

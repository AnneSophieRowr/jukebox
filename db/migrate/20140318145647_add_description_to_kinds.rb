class AddDescriptionToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :description, :text
  end
end

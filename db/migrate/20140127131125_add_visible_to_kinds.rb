class AddVisibleToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :visible, :boolean, default: false
  end
end

class RemoveKindOfRecords < ActiveRecord::Migration
  def change
    remove_column :records, :kind
  end
end

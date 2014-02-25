class AddTimestampsToRecords < ActiveRecord::Migration
  def change
    add_column(:records, :created_at, :datetime)
  end
end

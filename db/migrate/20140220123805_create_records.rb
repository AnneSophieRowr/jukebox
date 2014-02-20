class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer   :recordable_id,     null: false
      t.string    :recordable_type,  null: false
      t.string    :kind
      t.time      :start_time
      t.time      :end_time
    end
  end
end

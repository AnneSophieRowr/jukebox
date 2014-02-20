class Record < ActiveRecord::Base
  belongs_to :recordable, polymorphic: true

  def self.total(type)
    where('recordable_type = ?', type).count(group: "recordable_id")
  end

  def self.kind(type)
  end
end

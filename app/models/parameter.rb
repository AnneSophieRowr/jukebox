class Parameter < ActiveRecord::Base
  validates :name, uniqueness: true
  validates_presence_of :name, :value
end

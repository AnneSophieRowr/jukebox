class Parameter < ActiveRecord::Base
  include Synchronizable

  validates :name, uniqueness: true
  validates_presence_of :name, :value
end

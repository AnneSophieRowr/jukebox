module Synchronizable
  extend ActiveSupport::Concern

  module ClassMethods
    def updated(date)
      results = where('updated_at > ? and published is true', date)
    end
  end 

end

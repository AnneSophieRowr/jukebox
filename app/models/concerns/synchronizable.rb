module Synchronizable
  extend ActiveSupport::Concern

  module ClassMethods
    def updated(date)
      results = where('updated_at > ?', date)
    end
  end 

end

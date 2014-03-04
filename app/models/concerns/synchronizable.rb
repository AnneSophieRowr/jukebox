module Synchronizable
  extend ActiveSupport::Concern

  module ClassMethods
    def updated(date)
      where('updated_at > ?', date)
    end
  end 

end

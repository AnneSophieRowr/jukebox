module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(q)
      where('name LIKE ?', q)
    end 

    def sort_column
      column = self.column_names.include? 'name' ? 'name asc' : 'last_name asc'
      column
    end 
  end 

end

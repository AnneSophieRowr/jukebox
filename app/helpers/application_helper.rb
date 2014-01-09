module ApplicationHelper

  def kinds
   Kind.all.collect {|c| [c.name.capitalize, c.id]}
  end

end

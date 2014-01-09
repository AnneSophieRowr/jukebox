class UserDecorator < Draper::Decorator
  delegate_all

  def name
    "#{object.first_name.capitalize} #{object.last_name.capitalize}"
  end

end

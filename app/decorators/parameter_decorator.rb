class ParameterDecorator < Draper::Decorator
  delegate_all

  def name
    object.name.capitalize
  end

end

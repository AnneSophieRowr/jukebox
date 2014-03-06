class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def synchronize
    data = Synchronizer.data('2014-01-02')
    render json: data.to_json
  end

  def import_log
    send_file 'log/import.log' 
  end

end

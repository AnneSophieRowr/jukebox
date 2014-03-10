class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def synchronize
    date = params[:date].nil? ? Date.today.strftime('%Y-%m-%d') : params[:date]
    puts date
    data = Synchronizer.data(date)
    render json: data.to_json
  end

  def import_log
    send_file 'log/import.log' 
  end

end

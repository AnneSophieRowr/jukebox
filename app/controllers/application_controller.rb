class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: :synchronize
  after_filter :cors_set_headers, only: :synchronize
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

  def cors_set_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end

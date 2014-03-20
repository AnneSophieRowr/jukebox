class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: [:synchronize, :files]
  after_filter :cors_set_headers, only: [:synchronize, :files]
  protect_from_forgery with: :exception
  #Mime::Type.register "application/zip", :zip

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def synchronize
    date = params[:date].nil? ? Date.today.strftime('%Y-%m-%d') : params[:date]
    data = Synchronizer.data(date)
    render json: data.to_json
  end

  def files
    date = params[:date].nil? ? Date.today.strftime('%Y-%m-%d') : params[:date]
    folder = "public"
    input_filenames = Song.updated(date).collect {|song| song.file.url}
    zipfile_name = 'public/test.zip'
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename[1, filename.length], folder + filename)
      end
    end
    send_file zipfile_name
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

class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: [:synchronize, :files]
  after_filter :cors_set_headers, only: [:synchronize, :files]
  protect_from_forgery with: :exception

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def synchronize
    date = params[:date].nil? ? Date.today.strftime('%Y-%m-%d') : params[:date]
    data = Synchronizer.data(date)
    render json: data.to_json
  end

  def files
    FileUtils.rm_rf(Dir.glob("public/*.zip"))
    date = params[:date].nil? ? Date.today.strftime('%Y-%m-%d') : params[:date]
    songs = Song.updated(date)
    artists = Artist.updated(date)
    albums = Album.updated(date)
    input_filenames = (songs.collect {|s| s.file.url} + songs.collect {|s| s.image.url} + artists.collect {|a| a.image.url} + albums.collect {|a| a.image.url}).reject! {|f| f.include? 'default.jpg'}
    Zip::File.open('public/updated_files.zip', Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename[9, filename.length], 'public' + filename)
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

class SongsController < ApplicationController
  before_action :set_song, only: [:play, :show, :edit, :update, :destroy]
  before_action :fix_duration_params, only: [:create, :update]

  def index
    @songs = Kaminari.paginate_array(SongDecorator.decorate_collection(Song.all)).page(params[:page])
  end

  def show
    @song = @song.decorate
  end

  def import
    Song.import(params[:import][:file].tempfile, current_user)
    songs = Kaminari.paginate_array(SongDecorator.decorate_collection(Song.all)).page(params[:page])
    render partial: 'listing', locals: {songs: songs}
  end

  def play
    artist = @song.artist.nil? ? "" : @song.artist.name
    song_data = {title: @song.name, artist: artist, mp3: @song.file.url, poster: @song.image.url}
    render json: song_data.to_json
  end

  def search
    q = "%#{params[:q]}%"
    songs = Song.where("name like ? or artist_id in (select id from artists where name like ? )", q, q)
    songs.collect! {|s| {artist: (s.artist.nil? ? "" : s.artist.name), album: s.decorate.albums_view, img: s.image.url(:thumb), title: s.name, song_id: s.id}}
    render json: songs.to_json
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: t('song.create', name: @song.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: t('song.update', name: @song.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @song.name
    @song.destroy
      respond_to do |format|
      format.html { redirect_to songs_url, notice: t('song.destroyed', name: name) }
    end
  end

  private
  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :image, :file, :artist_id, :duration, :user_id, playlist_ids: [], album_ids: [])
  end

  def fix_duration_params
    unless params[:song][:duration].empty?
      time = Time.parse("00:#{params[:song][:duration]}")
      duration = time.min*60 + time.sec
      puts duration
      params[:song].merge!({'duration' => duration})
    end
  end

end

class SongsController < ApplicationController
  before_action :set_song, only: [:play, :edit, :update, :destroy]

  def index
    @songs = SongDecorator.decorate_collection(Song.all)
  end

  def import
    Song.import(params[:import][:file].tempfile, current_user)
    render partial: 'listing', locals: {songs: SongDecorator.decorate_collection(Song.all)}
  end

  def play
    artist = @song.artist.nil? ? "" : @song.artist.name
    song_data = {title: @song.name, artist: artist, mp3: @song.file.url, poster: @song.image.url}
    render json: song_data.to_json
  end

  def search
    q = "%#{params[:q]}%"
    songs = Song.where("name like ? or artist_id in (select id from artists where name like ? )", q, q)
    songs.collect! {|s| {artist: (s.artist.nil? ? "" : s.artist.name), album: s.decorate.albums, img: s.image.url(:thumb), title: s.name, song_id: s.id}}
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
        format.html { redirect_to songs_path, notice: t('song.create', name: @song.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to songs_path, notice: t('song.update', name: @song.name) }
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

end

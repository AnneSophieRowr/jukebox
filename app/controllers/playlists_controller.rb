class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:add_song, :sort, :manage, :play, :show, :edit, :update, :destroy]

  def index
    @playlists = PlaylistDecorator.decorate_collection(Playlist.all)
  end

  def add_song
    @playlist.add_song(params[:song_id]) 
    render nothing: true
  end

  def play
    songs_data = @playlist.songs.order('position asc').collect {|s| {title: s.name, artist: s.artist, mp3: s.file.url}}
    render json: songs_data.to_json
  end

  def sort
    @playlist_songs = PlaylistsSong.where(:playlist_id => @playlist.id, :song_id => params[:song])
    @playlist_songs.each do |ps|
      ps.position = params['song'].index(ps.song.id.to_s) + 1
      ps.save
    end
    render :nothing => true
  end

  def manage
  end

  def new
    @playlist = Playlist.new
  end

  def edit
  end

  def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to playlists_path, notice: t('playlist.create', name: @playlist.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to playlists_path, notice: t('playlist.update', name: @playlist.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @playlist.name
    @playlist.destroy
      respond_to do |format|
      format.html { redirect_to playlists_url, notice: t('playlist.destroyed', name: name) }
    end
  end

  private
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :image, :kind_id, :user_id, song_ids: [])
  end

end

class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  def index
    @playlists = PlaylistDecorator.decorate_collection(Playlist.all)
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
    params.require(:playlist).permit(:name, :image, :kind_id, :user_id)
  end

end

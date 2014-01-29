class AlbumsController < ApplicationController
  before_action :set_album, only: [:sort, :manage, :add_song, :edit, :update, :destroy]

  def index
    @albums = Kaminari.paginate_array(AlbumDecorator.decorate_collection(Album.all)).page(params[:page])
  end

  def manage
  end

  def add_song
    song = Song.find(params[:song_id])
    ps = @album.add_song(params[:song_id]) 
    render partial: 'song', locals: {song: song, albums_song: ps}
  end

  def sort
    @album_songs = AlbumSong.where(:album_id => @playlist.id, :song_id => params[:song])
    @album_songs.each do |as|
      as.position = params['song'].index(as.song.id.to_s) + 1
      as.save
    end
    render :nothing => true
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_path, notice: t('album.create', name: @album.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to albums_path, notice: t('album.update', name: @album.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @album.name
    @album.destroy
      respond_to do |format|
      format.html { redirect_to albums_url, notice: t('album.destroyed', name: name) }
    end
  end

  private
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :image, :year, :artist_id)
  end

end

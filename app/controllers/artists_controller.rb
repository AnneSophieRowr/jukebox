class ArtistsController < ApplicationController
  before_action :set_artist, only: [:play, :edit, :update, :destroy]

  def index
    @artists = ArtistDecorator.decorate_collection(Artist.all)
  end

  def new
    @artist = Artist.new
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to artists_path, notice: t('artist.create', name: @artist.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to artists_path, notice: t('artist.update', name: @artist.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @artist.name
    @artist.destroy
      respond_to do |format|
      format.html { redirect_to artists_url, notice: t('artist.destroyed', name: name) }
    end
  end

  private
  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :image, :description)
  end

end

class AlbumsSongsController < ApplicationController
  before_action :set_albums_song, only: [:destroy]

  def destroy
    @albums_song.destroy
    render nothing: true
  end

  private
  def set_albums_song
    @albums_song = AlbumsSong.find(params[:id])
  end

  def albums_song_params
    params.require(:albums_song).permit(:album_id, :song_id, :position)
  end

end

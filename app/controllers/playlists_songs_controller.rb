class PlaylistsSongsController < ApplicationController
  before_action :set_playlists_song, only: [:destroy]

  def destroy
    @playlists_song.destroy
    render nothing: true
  end

  private
  def set_playlists_song
    @playlists_song = PlaylistsSong.find(params[:id])
  end

  def playlists_song_params
    params.require(:playlists_song).permit(:playlist_id, :song_id, :position)
  end

end

class Playlist < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :kinds
  belongs_to :user
  has_many :playlists_songs, order: :position
  has_many :songs, through: :playlists_songs


  def add_song(song_id)
    ps = PlaylistsSong.new(playlist_id: self.id, song_id: song_id)
    ps.save!
  end

  require 'zip'
  def self.import(tempfile)
    # Extract directories (structure)
    #Zip::File.open(tempfile) do |zipfile|
    #  zipfile.each do |f|
    #    FileUtils.mkpath("public/temp/#{f.name}") if f.directory? and !File.directory? f.name
    #  end
    #end

    # Extract files
    #Zip::File.open(tempfile) do |zipfile|
    #  zipfile.each do |f|
    #    zipfile.extract(f, "public/temp/#{f.name}") unless f.directory?
    #  end
    #end

    playlists = Dir.entries('public/temp')
    playlists.reject! {|p| p.include? '.'}
    playlists.each do |p|
      playlist = Playlist.new(name: p)
      playlist.user_id = 1
      playlist.save!
    end


  end

end

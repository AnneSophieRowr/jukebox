class Playlist < ActiveRecord::Base
  include Searchable

  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :kinds_playlists
  has_many :kinds, :through => :kinds_playlists

  has_many :playlists_songs, order: :position, dependent: :destroy
  has_many :songs, through: :playlists_songs

  has_many :playlists_types, dependent: :destroy
  has_many :types, through: :playlists_types

  has_many :records, as: :recordable

  validates_presence_of :name

  def add_song(song_id)
    ps = PlaylistsSong.new(playlist_id: self.id, song_id: song_id)
    ps.save!
  end

  def details
    ["#{songs.count} titre(s)", decorate.types_view].reject(&:blank?).join(' - ')
  end

  def self.updated(date)
    results = where('updated_at > ? and published is true', date)
  end

  require 'zip'
  #require 'mp3info'
  def self.import(tempfile, user)
    begin
      temp_path = 'public/temp'

      # Extract directories (structure)
      Zip::File.open(tempfile) do |zipfile|
        zipfile.each do |f|
          FileUtils.mkpath("#{temp_path}/#{f.name}") if f.directory? and !File.directory? f.name
        end
      end

      # Extract files
      Zip::File.open(tempfile) do |zipfile|
        zipfile.each do |f|
          zipfile.extract(f, "#{temp_path}/#{f.name}") unless f.directory?
        end
      end

      # Getting each playlist from extacted files
      playlists = Dir.entries(temp_path).reject! {|p| p.include? '.'}

      playlists.each do |p|
        path = "#{temp_path}/#{p}/"
        playlist = Playlist.new(user: user)

        # Retrieve infos.txt + playlist image + songs
        infos = File.open("#{path}infos.txt").read
        img = File.open("#{path}img.jpg")
        songs = Dir.entries("#{path}songs/").reject! {|s| ['.', '..'].include? s or s.include? '.jpg'}
        images = Dir.entries("#{path}songs/").reject! {|s| ['.', '..'].include? s or s.include? '.mp3'}

        # Reading playlist infos from infos.txt + assign kinds to playlist
        infos.each_line.with_index do |line, idx|
          if idx == 0
            playlist.name = line.capitalize 
          elsif idx == 1
            kinds = line.split(';').collect {|k| k.squish.capitalize}
            kinds = kinds.collect {|kind| Kind.find_or_create_by(name: kind)}
            kinds.each {|kind| KindsPlaylist.create(kind: kind, playlist: playlist)}
          else 
            break
          end
        end

        # Affect image to playlist
        playlist.image = img

        songs.each do |song|
          #mp3 = Mp3Info.open("#{path}songs/#{song}") 
          mp3 = ""
          infos = mp3.tag.empty? ? mp3.tag1 : mp3.tag
          unless infos.empty?
            new_song = Song.new(name: infos.title.capitalize, album: infos.album.capitalize, user: user)

            new_song.artist = Artist.find_or_create_by(name: infos.artist.downcase)

            image = "#{path}songs/#{song.gsub('.mp3', '.jpg')}"
            new_song.image = File.exist?(image) ? File.open(image) : infos.image

            new_song.file = File.open("#{path}songs/#{song}")

            song_exists = Song.where(name: new_song.name, artist: new_song.artist, album: new_song.album)
            if song_exists.empty?
              new_song.save! 
            else
              new_song = song_exists.first
            end

            PlaylistsSong.create(playlist_id: playlist.id, song_id: new_song.id) 
          end
        end
        playlist.save!
      end
    rescue Exception => e
    end
    FileUtils.rm_rf(Dir.glob('public/temp/*'))
  end

end

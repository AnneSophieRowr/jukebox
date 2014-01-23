class Song < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  belongs_to :user
  belongs_to :artist

  has_many :playlists_songs, order: :position, dependent: :destroy
  has_many :playlists, through: :playlists_songs

  has_many :albums_songs, order: :position, dependent: :destroy
  has_many :albums, through: :albums_songs

  validates_presence_of :file, :name

  require 'zip'
  require 'mp3info'
  def self.import(tempfile, user)
    begin
      # Extract files
      Zip::File.open(tempfile) do |zipfile|
        zipfile.each do |f|
          zipfile.extract(f, "public/temp/#{f.name}") 
        end
      end

      songs = Dir.entries("public/temp/").reject! {|s| ['.', '..'].include? s or !s.include? 'mp3'}

      songs.each do |song|
        mp3 = Mp3Info.open("public/temp/#{song}") 

        infos = mp3.tag.empty? ? mp3.tag1 : mp3.tag 
        unless infos.empty?
          new_song = Song.new(name: infos.title.capitalize, album: infos.album.capitalize, user: user)

          new_song.artist = Artist.find_or_create_by(name: infos.artist.downcase)

          image = "public/temp/#{song.gsub('.mp3', '.jpg')}"
          new_song.image = File.exist?(image) ? File.open(image) : infos.image

          new_song.file = File.open("public/temp/#{song}")

          song_exists = Song.where(name: new_song.name, album: new_song.album)
          new_song.save! if song_exists.empty?
        end
      end
    rescue Exception => e
      puts e
    end
    FileUtils.rm_rf(Dir.glob('public/temp/*'))
  end

  end

class Song < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  has_and_belongs_to_many :playlists
  belongs_to :user
  has_many :playlists_songs, order: :position
  has_many :playlists, through: :playlists_songs

  validates_presence_of :file, :name

  require 'zip'
  require 'mp3info'
  def self.import(tempfile, user)
    # Extract files
    Zip::File.open(tempfile) do |zipfile|
      zipfile.each do |f|
        zipfile.extract(f, "public/temp/#{f.name}") 
      end
    end

    songs = Dir.entries("public/temp/").reject! {|s| ['.', '..'].include? s or !s.include? 'mp3'}

    songs.each do |song|
      Mp3Info.open("public/temp/#{song}") do |mp3|
        new_song = Song.new(name: mp3.tag.title.capitalize, artist: mp3.tag.artist.capitalize, album: mp3.tag.album.capitalize, user: user)

        image = "public/temp/#{song.gsub('.mp3', '.jpg')}"
        new_song.image = File.exist?(image) ? File.open(image) : mp3.tag.image

        new_song.file = File.open("public/temp/#{song}")

        test = Song.where(name: new_song.name, artist: new_song.artist, album: new_song.album)
        new_song.save! if test.empty?
      end
    end
    FileUtils.rm_rf(Dir.glob('public/temp/*'))

  end

end

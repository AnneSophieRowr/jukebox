class Song < ActiveRecord::Base
  include Searchable
  include Synchronizable

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  belongs_to :user
  belongs_to :artist

  has_many :playlists_songs, order: :position, dependent: :destroy
  has_many :playlists, through: :playlists_songs

  has_many :albums_songs, order: :position, dependent: :destroy
  has_many :albums, through: :albums_songs

  has_many :records, as: :recordable

  validates_presence_of :file, :name

  def details
    details = self.decorate.albums_view
    details = "#{artist.decorate.name} - #{details}" unless artist.nil?
    return details
  end

  require 'zip'
  require 'mp3info'
  def self.import(tempfile, user)

    File.delete('log/import.log') if File.exist?('log/import.log')
    import_logger = Logger.new('log/import.log')

    import_logger.info "########## Starting songs import ##########"
    begin

      import_logger.info "Extracting Zip file..."
      Zip::File.open(tempfile) do |zipfile|
        zipfile.each do |f|
          zipfile.extract(f, "public/temp/#{f.name}") 
        end
      end
      import_logger.info "Zip file extracted."

      songs = Dir.entries("public/temp/").reject! {|s| ['.', '..'].include? s or !s.include? 'mp3'}

      import_logger.info "Importing #{songs.size} song(s)"
      songs.each_with_index do |song, idx|
        begin
          import_logger.info '*'*10
          import_logger.info "Importing song n°#{idx + 1} #{song}"
          mp3 = Mp3Info.open("public/temp/#{song}") 

          infos = mp3.tag.empty? ? mp3.tag1 : mp3.tag 
          if infos.empty?
            import_logger.error "Error importing song: no mp3 infos"
          else
            new_song = Song.new(name: infos.title.capitalize, user: user)

            new_song.artist = Artist.find_or_create_by(name: infos.artist.downcase)

            album = Album.find_or_create_by(name: infos.album.downcase)
          
            image = "public/temp/#{song.gsub('.mp3', '.jpg')}"
            new_song.image = File.exist?(image) ? File.open(image) : infos.image

            new_song.file = File.open("public/temp/#{song}")

            song_exists = Song.where(name: new_song.name)

            if song_exists.empty?
              new_song.save! 
              new_song.albums << album
              import_logger.info "Saving song: #{new_song.name}"
            else
              import_logger.info "Song already exists" 
            end
          end
        rescue => e
          import_logger.error "Error importing song: #{e}"
          next
        end
      end
    rescue => e
      import_logger.error "******************* Error importing songs"
      import_logger.error e.inspect
      import_logger.error "***************"
    end
    FileUtils.rm_rf(Dir.glob('public/temp/*'))
    import_logger.info "########## Finished songs import ##########"
  end

  end

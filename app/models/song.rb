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
  require 'taglib'
  def self.import(tempfile, user)

    format_regex = /(\.mp3|\.mp4|\.m4a|\.wav|\.ogg|\.flac|\.wma)$/ 

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

      songs = Dir.entries("public/temp/").reject! {|s| ['.', '..'].include? s or format_regex.match(s).nil?}

      import_logger.info "Importing #{songs.size} song(s)"
      songs.each_with_index do |song, idx|
        begin
          import_logger.info '*'*10
          import_logger.info "Importing song n°#{idx + 1} #{song}"

          TagLib::FileRef.open("public/temp/#{song}") do |mp3|
            infos = mp3.tag
            if infos.empty?
              import_logger.error "Error importing song: no mp3 infos"
            else
              new_song = Song.new(name: infos.title.capitalize, user: user)

              new_song.duration = mp3.audio_properties.length

              new_song.artist = Artist.find_or_create_by(name: infos.artist.downcase)

              album = Album.find_or_create_by(name: infos.album.downcase)
            
              image = "public/temp/#{song.gsub('.mp3', '.jpg')}"
              image = image.gsub('.mp4', '.jpg')
              image = image.gsub('.m4a', '.jpg')
              image = image.gsub('.jpg', '.png') unless File.exist? image
              image = image.gsub('.png', '.jpeg') unless File.exist? image
              
              image = "public/temp/#{song}"[0..-4] + 'jpg'
              if !File.exist? image
                image = image.gsub('.jpg', '.png')
                if !File.exist? image
                  image = image.gsub('.png', '.jpeg')
                  if !File.exist? image
                    image = infos.image
                  end
                end
              end

              new_song.image = File.open(image)

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

# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  def extension_white_list
     %w(mp3 wma)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end

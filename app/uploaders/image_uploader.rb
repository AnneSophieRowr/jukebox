# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  process :resize_to_fit => [150, 150]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [50, 50]
  end
  
  def default_url
    "default.jpg"
    [version_name, "default.jpg"].compact.join('_')
  #  ActionController::Base.helpers.asset_path("default.jpg")
  #  ActionController::Base.helpers.asset_path([version_name, "default.jpg"].compact.join('_'))
  end

end

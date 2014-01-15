class Kind < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :kinds
end

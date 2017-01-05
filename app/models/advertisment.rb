class Advertisment < ActiveRecord::Base

  ATTRIBUTES_ROLES = [:read, :create, :update, :destroy, :destroy_all]

  validates :description, presence: true
  validates :url, presence: true
  mount_uploader :image, AdvertismentImageUploader
end

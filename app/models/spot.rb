class Spot < ApplicationRecord
  belongs_to :user
  has_many :checkins
  has_many :locations
  has_many :spot_contents
  mount_uploader :default_image, PhotoUploader
end

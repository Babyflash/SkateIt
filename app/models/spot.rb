class Spot < ApplicationRecord
  belongs_to :user
  has_many :checkins
  has_many :locations
  has_many :spot_contents
  has_many :posts, dependent: :destroy
  # has_many :post_contents, through: :post
  validates_presence_of :default_image
  validates_inclusion_of :spot_rating, :in => 1..5
  validates_inclusion_of :difficulty_rating, :in => 1..10
  mount_uploader :default_image, PhotoUploader
end

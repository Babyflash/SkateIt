class Spot < ApplicationRecord
  # acts_as_token_authenticatable

  belongs_to :user
  has_many :checkins
  has_many :locations
  has_many :spot_contents
  has_many :posts, dependent: :destroy
  # has_many :post_contents, through: :post
  validates_presence_of :default_image, :message => "You must upload an image!"
  # validates_inclusion_of :spot_rating, :in => 1..5, :message => "must be between 1 and 5"
  validates_inclusion_of :difficulty_rating, :in => 1..10, :message => "must be between 1 and 10"


  mount_uploader :default_image, PhotoUploader
  attr_accessor :default_image

  include PgSearch

  pg_search_scope :search_by_type,
    against: [ :spot_type ],
    using: {
      tsearch: { prefix: true }
    }
end

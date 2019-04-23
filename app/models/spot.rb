class Spot < ApplicationRecord
  belongs_to :user
  has_many :checkins
  has_many :locations
  has_many :spot_contents
end

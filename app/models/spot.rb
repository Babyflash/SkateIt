class Spot < ApplicationRecord
  belongs_to :skater
  has_many :checkins
  has_many :locations
  has_many :spot_contents
end

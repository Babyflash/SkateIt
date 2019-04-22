class Skater < ApplicationRecord
  has_many :favorites
  has_many :posts
  has_many :checkins
  has_many :spots
end

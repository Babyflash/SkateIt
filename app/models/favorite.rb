class Favorite < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :spot_id
end

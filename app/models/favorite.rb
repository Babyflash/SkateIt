class Favorite < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id, :spot_id
end

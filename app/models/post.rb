class Post < ApplicationRecord
  belongs_to :skater
  has_many :post_contents
end

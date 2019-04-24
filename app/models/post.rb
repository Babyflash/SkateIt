class Post < ApplicationRecord
  belongs_to :user
  has_many :post_contents
  belongs_to :spot

  # mount_uploaders :pictures, PictureUploader
end

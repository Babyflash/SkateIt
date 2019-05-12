class PostContent < ApplicationRecord
  mount_uploader :media_url, PhotoUploader
  belongs_to :post
end

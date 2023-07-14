class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :story_image
end
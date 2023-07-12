class Post < ApplicationRecord
  validates :description, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :post_image
end

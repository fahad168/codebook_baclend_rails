class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  has_many :authentication_tokens, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end

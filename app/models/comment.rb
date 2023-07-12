class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true
  belongs_to :parent_comment, class_name:  'Comment',optional: true
  has_many :comments,foreign_key: :parent_comment_id
  has_one_attached :comment_image, dependent: :destroy
end

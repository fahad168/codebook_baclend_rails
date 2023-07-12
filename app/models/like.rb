class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum like_status: %w[nothing like dislike]
end

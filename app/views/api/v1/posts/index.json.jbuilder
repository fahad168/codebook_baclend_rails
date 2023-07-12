json.posts @posts.each do |post|
  json.id post.id
  json.description post.description
  json.created_at post.created_at
  json.post_image post.post_image.attached? ? post.post_image.blob.url : ''
  json.content_type post.post_image.attached? ? post.post_image.blob.content_type : ''
  json.like do
    json.id post.likes.where(user_id: @current_user.id)&.first&.id
    json.is_liked post.likes.where(like_status: 1).pluck(:user_id).include?(@current_user.id)
    json.likes_count post.likes.where(like_status: 1).count
  end
  json.user do
    json.user_id post.user.id
    json.username post.user.username
    json.profile_image post.user.profile_image.attached? ? post.user.profile_image.blob.url : ''
  end
end
json.post_images @post_images.each do |image|
  json.id image.id
  json.post_image image.post_image.attached? ? image.post_image.blob.url : ''
  json.likes_count Like.where(post_id: image.id).count
  json.is_liked_current_user Like.where(post_id: image.id, user_id: @current_user.id).count == 1 ? true : false
  json.user_id image.user.id
  json.username image.user.username
  json.profile_image image.user.profile_image.attached? ? image.user.profile_image.blob.url : ''
end
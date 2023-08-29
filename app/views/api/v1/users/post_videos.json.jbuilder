json.post_videos @post_videos.each do |video|
  json.id video.id
  json.post_video video.post_image.attached? ? video.post_image.blob.url : ''
  json.likes_count Like.where(post_id: video.id).count
  json.is_liked_current_user Like.where(post_id: video.id, user_id: @current_user.id).count == 1 ? true : false
  json.user_id video.user.id
  json.username video.user.username
  json.profile_image video.user.profile_image.attached? ? video.user.profile_image.blob.url : ''
end
json.videos @videos.each do |video|
  json.id video.id
  json.description video.description
  json.created_at video.created_at
  json.post_image video.post_image.attached? ? video.post_image.blob.url : ''
  json.content_type video.post_image.attached? ? video.post_image.blob.content_type : ''
  json.like do
    json.id video.likes.where(user_id: @current_user.id)&.first&.id
    json.is_liked video.likes.where(like_status: 1).pluck(:user_id).include?(@current_user.id)
    json.likes_count video.likes.where(like_status: 1).count
  end
  json.user do
    json.user_id video.user.id
    json.username video.user.username
    json.profile_image video.user.profile_image.attached? ? video.user.profile_image.blob.url : ''
  end
end
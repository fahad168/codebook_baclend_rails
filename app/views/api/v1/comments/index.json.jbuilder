json.comments @comments.each do |comment|
  json.id comment.id
  json.body comment.body
  json.post_id comment.post_id
  json.comment_image comment.comment_image.attached? ? comment.comment_image.blob.url : ''
  json.content_type comment.comment_image.attached? ? comment.comment_image.blob.content_type : ''
  json.created_at comment.created_at
  json.child_comments_count Comment.where(parent_comment_id: comment.id).count
  user = User.find_by(id: comment.user_id)
  json.user do
    json.id user.id
    json.username user.username
    json.email user.email
    json.profile_image user.profile_image.attached? ? user.profile_image.blob.url : ''
  end
end
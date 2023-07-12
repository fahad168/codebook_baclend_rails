json.child_comment do
  json.id @child_comment.id
  json.body @child_comment.body
  json.parent_comment_id @child_comment.parent_comment_id
  json.post_id @child_comment.post_id
  json.comment_image @child_comment.comment_image.attached? ? @child_comment.comment_image.blob.url : ''
  json.content_type @child_comment.comment_image.attached? ? @child_comment.comment_image.blob.content_type : ''
  user = User.find_by(id: @child_comment.user_id)
  json.user do
    json.id user.id
    json.username user.username
    json.email user.email
    json.profile_image user.profile_image.attached? ? user.profile_image.blob.url : ''
  end
end
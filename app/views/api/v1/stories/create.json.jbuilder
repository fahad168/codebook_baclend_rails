json.story do
  json.id @story.id
  json.text @story.text
  json.story_image @story.story_image.attached? ? @story.story_image.blob.url : ''
  json.duration @story.duration
  json.created_at @story.created_at
  json.message 'Story Created Successfully'
  user = User.find_by(id: @story.user_id)
  json.user do
    json.id user.id
    json.username user.username
    json.email user.email
    json.profile_image user.profile_image.attached? ? user.profile_image.blob.url : ''
  end
end
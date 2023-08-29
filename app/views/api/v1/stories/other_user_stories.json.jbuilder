json.other_user_stories @stories_users.each do |user|
  json.stories user.stories.each do |story|
    json.id story.id
    json.text story.text
    json.story_image story.story_image.attached? ? story.story_image.blob.url : ''
    json.duration story.duration
    json.created_at story.created_at
    json.content_type story.story_image.attached? ? story.story_image.blob.content_type : ''
    json.user do
      json.id user.id
      json.username user.username
      json.email user.email
      json.profile_image user.profile_image.attached? ? user.profile_image.blob.url : ''
    end
  end
end
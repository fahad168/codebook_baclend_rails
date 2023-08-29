json.shorts @shorts.each do |short|
  json.id short.id
  json.post_image short.post_image.blob.url
  json.thumbnail short.thumbnail
  json.created_at short.created_at
  json.content_type short.post_image.attached? ? short.post_image.blob.content_type : ''
  json.user do
    json.id short.user.id
    json.username short.user.username
    json.email short.user.email
    json.profile_image short.user.profile_image.attached? ? short.user.profile_image.blob.url : ''
  end
end
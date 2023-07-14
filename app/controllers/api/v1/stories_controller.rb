class Api::V1::StoriesController < Api::V1::ApiController
  before_action :authorize_request

  def index
    @stories = @current_user.stories.all
    return render json: { stories: [] }, status: :ok unless @stories.present?
  end

  def create
    @story = Story.new(story_params)
    return render_error_messages(@story) unless @story.save
  end

  private

  def story_params
    params.permit(:text, :duration, :story_image).merge(user_id: @current_user.id)
  end
end
class Api::V1::PostsController < Api::V1::ApiController
  before_action :authorize_request

  def index
    @posts = Post.where(video_type: nil).order('created_at DESC').paginate(page: params[:page], per_page: 5)

    return render json: { posts: [] }, status: :ok unless @posts.present?
  end
  def create
    @post = Post.create(post_params)
    @post.post_type = @post.post_image.blob.content_type

    return render json: { error: @post.errors.full_messages }, status: :unprocessable_entity unless @post.save
    if @post.post_image.attached? && @post.post_image.video? && @post.video_type == 'short'
      thumbnail = ''
      if @post.post_image.previewable?
        video_preview = @post.post_image.preview(resize_to_limit: [500, 500])
        thumbnail = video_preview.processed
      end
      @post.update(thumbnail: thumbnail&.url)
    end

    render json: { post: @post, post_image: @post.post_image.attached? ? @post.post_image.blob.url : '', message: 'Post Successfully Created' }, status: :ok
  end

  def trending_posts; end

  def shorts
    @shorts = Post.where(video_type: 'short')
    return render json: { shorts: [] }, status: :ok unless @shorts.present?
  end

  def videos
    @videos = Post.where.not(post_type: 'image/jpeg').paginate(page: params[:page], per_page: 5)
    return render json: { videos: [] }, status: :ok unless @videos.present?
  end

  private

  def post_params
    params.permit(:description, :video_type, :post_image).merge(user_id: @current_user.id)
  end
end
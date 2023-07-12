class Api::V1::PostsController < Api::V1::ApiController
  before_action :authorize_request

  def index
    @posts = Post.order('created_at DESC').paginate(page: params[:page], per_page: 5)

    return render json: { posts: [] }, status: :ok unless @posts.present?
  end
  def create
    @post = Post.create(post_params)

    return render json: { error: @post.errors.full_messages }, status: :unprocessable_entity unless @post.save

    render json: { post: @post, post_image: @post.post_image.attached? ? @post.post_image.blob.url : '', message: 'Post Successfully Created' }, status: :ok
  end

  private

  def post_params
    params.permit(:description, :post_image).merge(user_id: @current_user.id)
  end
end
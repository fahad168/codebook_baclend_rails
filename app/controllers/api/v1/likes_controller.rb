class Api::V1::LikesController < Api::V1::ApiController
  before_action :authorize_request
  before_action :find_post

  def like_post
    @like = @post.likes.find_by(like_status: 2, user_id: @current_user.id)
    if @like.present?
      return render json: { error: 'something went wrong' }, status: :unprocessable_entity unless @like.update(like_status: 1)
    else
      @like = @post.likes.create(like_status: 1, user_id: @current_user.id)

      return render_error_messages(@like) unless @like.save
    end
    render json: { message: 'Successfully Liked The Post', like: @like }, status: :ok
  end

  def dislike_post
    @like = @post.likes.find_by(id: params[:like_id])
    return render json: { error: 'Something Went Wrong' }, status: :unprocessable_entity unless @like.update(like_status: 2)

    render json: { message: 'disliked successfully', like: @like }, status: :ok
  end


  private

  def find_post
    return render json: { message: 'Post not found' }, status: :unprocessable_entity unless (@post = Post.find_by(id: params[:post_id]))
  end
end
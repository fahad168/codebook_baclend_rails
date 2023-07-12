class Api::V1::CommentsController < Api::V1::ApiController
  before_action :authorize_request
  before_action :find_post

  def index
    @comments = @post.comments.where(parent_comment_id: nil).order('created_at DESC')

    return render json: { message: 'No Comment Present' }, status: :unprocessable_entity unless @comments.present?
  end

  def child_comments
    @child_comments = @post.comments.where(parent_comment_id: params[:parent_comment_id]).order('created_at DESC')

    return render json: { message: 'No Comment Present' }, status: :unprocessable_entity unless @child_comments.present?
  end

  def create_comment
    @comment = @post.comments.create(comment_params)
    return render_error_messages(@comment) unless @comment.save
  end

  def create_child_comment
    @child_comment = @post.comments.create(comment_params)
    @child_comment.parent_comment_id = params[:parent_comment_id]
    return render_error_messages(@comment) unless @child_comment.save
  end

  private

  def comment_params
    params.permit(:body, :comment_image).merge(user_id: @current_user.id)
  end

  def find_post
    return render json: { message: 'No post found' }, status: :unprocessable_entity unless (@post = Post.find_by(id: params[:post_id]))
  end
end
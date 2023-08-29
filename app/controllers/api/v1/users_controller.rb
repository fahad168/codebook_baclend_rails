class Api::V1::UsersController < Api::V1::ApiController
  before_action :authorize_request, except: %i[create email_validate]
  before_action :find_user, except: %i[create email_validate post_images post_videos]
  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: { user: @user,
                   profile_image: @user.profile_image.attached? ? @user.profile_image.blob.url : '' },
           status: :ok
  end

  def create
    @user = User.new(user_params)

    return render_error_messages(@user) unless @user.save

    render json: { user: @user,
                   profile_image: @user.profile_image.attached? ? @user.profile_image.blob.url : '',
                   # wallet: @user.get_wallet,
                   message: 'User created successfully' }, status: :ok
      # MobileDevice.find_or_create_by(mobile_token: params[:mobile_token], user_id: @user.id)
  end

  def email_validate
    @user = User.find_by_email(params[:email])
    if @user.present?
      return render json: { message: 'Email present', email_status: true }, status: :unprocessable_entity
    else
      return render json: { message: 'Email not present', email_status: false }, status: :ok
    end
  end

  # PUT /users/{username}
  def update_user
    unless @current_user.update(user_params)
      render_error_messages(@user)
    else
      @current_user.update(user_params)
      render json: { user: @current_user,
                     profile_image: @current_user.profile_image.attached? ? @current_user.profile_image.blob.url : '',
                     message: "Profile Updated" },
             status: :ok
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
    render json: { message: 'User Successfully Deleted' }, status: :ok
  end

  def post_images
    @post_images = @current_user.posts.where(post_type: 'image/jpeg')
    return render json: { message: 'No Images Found', post_images: [] }, status: :ok unless @post_images.present?
  end

  def post_videos
    @post_videos = @current_user.posts.where(post_type: 'video/mp4', video_type: nil)
    return render json: { message: 'No Videos Found', post_videos: [] }, status: :ok unless @post_videos.present?
  end

  # def forgot_password
  #   @otp_generate = 4.times.map { rand(10) }.join
  #   @user.update(otp: @otp_generate)
  #   if UserMailer.user_forgot_password(@user.email, @otp_generate).deliver_now
  #     return render json: { message: 'OTP is sent successfully', otp: @otp_generate }, status: :ok
  #   else
  #     return render json: { message: 'OTP was not send successfully' }, status: :unprocessable_entity
  #   end
  # end

  # def verify_otp
  #   if @user.otp == params[:otp]
  #     if @user.updated_at < 1.minute.ago
  #       @user.update(otp: nil)
  #       return render json: { message: "OTP expired", user_otp: @user.otp, otp: params[:otp] }, status: :unprocessable_entity
  #     else
  #       @user.update(otp: nil)
  #       return render json: { message: "Correct OTP", user_otp: @user.otp, otp: params[:otp] }, status: :ok
  #     end
  #   else
  #     return render json: { message: "OTP is not valid", user_otp: @user.otp, otp: params[:otp] }, status: :unprocessable_entity
  #   end
  # end

  # def active_status_change
  #   if params[:status] == "false"
  #     @current_user.update(status: false)
  #     return render json: { message: "Active Status Changed", user_status: @current_user.status }, status: :ok
  #   end
  #   if params[:status] == "true"
  #     @current_user.update(status: true)
  #     return render json: { message: "Active Status Changed", user_status: @current_user.status }, status: :ok
  #   end
  #   if params[:status].empty? || params[:status] != "false" || params[:status] != "true"
  #     return render json: { message: "Empty or Invalid parameters", user_status: @current_user.status }, status: :ok
  #   end
  # end

  # def reset_user_password
  #   return render json: { message: 'Email cannot be empty' }, status: :unprocessable_entity if params[:email].empty?
  #
  #   return render json: { message: 'User with Email not found' }, status: :unprocessable_entity unless @user
  #
  #   return render json: { message: 'Password not present' }, status: :unprocessable_entity if params[:password].empty?
  #
  #   return render json: { message: 'Confirm Password not present' }, status: :unprocessable_entity if params[:password_confirmation].empty?
  #   if params[:password] == params[:password_confirmation]
  #     @user.update(password: params[:password], otp: nil)
  #     render json: { message: "Password updated" }, status: :ok
  #   else
  #     render json: { message: "Passwords don't match" }, status: :not_found
  #   end
  # end

  private

  def find_user
    unless (@user = User.find_by_email(params[:email]) || User.find_by_id(params[:id]))
      return render json: { message: 'User Not found' }, status: :not_found
    end
  end

  def user_params
    params.permit(:username, :email, :phone, :bio, :password, :password_confirmation, :profile_image)
  end
end

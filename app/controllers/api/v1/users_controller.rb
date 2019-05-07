class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json
  # protect_from_forgery prepend: true
  acts_as_token_authentication_handler_for User, except: [:create]
  skip_before_action :verify_authenticity_token, except: [:favorites, :profile]

  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze

  def create
    @user = User.find_by(email: wechat_email) || User.create(user_params)
    p '-------------------------USer----------------------'
    p @user
    render json: @user if @user.persisted?
  end

  def favorites
    if already_liked?
      fav = Favorite.where(user_id: params[:user_id], spot_id: params[:spot_id]).first
      if fav.destroy
        render json: { status: 'unliked' }
      else
        render_error(fav)
      end
    else
      fav = Favorite.new(user_id: params[:user_id], spot_id: params[:spot_id])
      if fav.save
        render json: { status: 'liked' }
      else
        render_error(fav)
      end
    end
  end

  def profile
    # spot_ids = Favorite.where(user_id: params[:user_id]).select('spot_id')
    spot_ids = Favorite.where(user_id: params[:user_id]).pluck(:spot_id)
    spots = []
    p "-----spotids-------#{spot_ids}"
    p spot_ids.to_a
    if spot_ids
      spots = Spot.where(id: spot_ids.to_a)
    end

    render json: spots
  end

  private

  def render_json(fav)
    if fav.save
      render json: fav if fav.persisted?
    else
      render_error(fav)
    end
  end

  def already_liked?
    Favorite.where(user_id: params[:user_id], spot_id: params[:spot_id]).exists?
  end

  def wechat_user
    @wechat_response ||= RestClient.post(URL, wechat_params)
    @wechat_user ||= JSON.parse(@wechat_response.body)
  end

  def wechat_params
    {
      appid: ENV["APPID"],
      secret: ENV["SECRET"],
      js_code: params[:code],
      grant_type: "authorization_code"
    }
  end

  def user_params
    return @user_params if @user_params

    @user_params = set_params

    # GET both openid and session_key
    @user_params['email'] = wechat_email
    @user_params['password'] = wechat_user.fetch('session_key', Devise.friendly_token)
    @user_params['authentication_token'] = Devise.friendly_token
    @user_params
  end

  def wechat_email
    @wechat_email ||= wechat_user.fetch('openid') + "@skateit.com"
    @wechat_email.downcase!
    return @wechat_email
  end

  def render_error(para)
    render json: { errors: para.errors.full_messages },
           status: :unprocessable_entity
  end

  def set_params
    params.require(:user).permit(:name, :avatar_url, :gender, :province, :city)
  end

end

class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json
  acts_as_token_authentication_handler_for User, except: [:create]
  skip_before_action :verify_authenticity_token

  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze

  def create
    
    @user = User.find_by(email: wechat_email) || User.create(user_params)
    p '-------------------------USer----------------------'
    p @user
    render json: @user if @user.persisted?
  end

  private

  def wechat_user
    @wechat_response ||= RestClient.post(URL, wechat_params)
    @wechat_user ||= JSON.parse(@wechat_response.body)
  end

  def wechat_params
    {
      appid: "wx75eca27293884352",
      secret: "dcb3e33d58a4ecf7d2223830f2f2a60e",
      js_code: params[:code],
      grant_type: "authorization_code"
    }
  end

  def user_params
    # return @user_params if @user_params

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

  def set_params
    params.require(:user).permit(:name, :avatar_url, :gender, :province, :city)
  end

end

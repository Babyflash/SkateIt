class Api::V1::SpotsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index]
  acts_as_token_authentication_handler_for Spot, except: [:index, :create]
  # protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  # skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    @spots = Spot.all
    # .sort((a, b) => (a.spot_type > b.spot_type) ? 1 : ((b.spot_type > a.spot_type) ? -1 : 0))
    @all_spots = {}

    Spot.distinct.pluck(:spot_type).each do |type|
      @all_spots[type] = Spot.where(:spot_type => type).order(created_at: :desc)
    end

    render json: @all_spots
  end

  def create
    p "Starting--------------"
    @spot = Spot.new(set_params)
    p params[:default_image]
    @spot.default_image = 'http://lc-j4J9R8FV.cn-n1.lcfile.com/88c88f5dd8ca2d79a41c'
    @spot.remote_default_image_url = params[:remote_default_image_url]
    p @spot.default_image
    # @spot.default_image = @spot.default_image.gsub('http://', 'https://')
    p "Starting--------------"
    if @spot.save
      p "SUCESS---------------------------------"
      render json: @spot if @spot.persisted?
      p @spot
    else
      render_error
    end
  end

  def render_error
    render json: { errors: @spot.errors.full_messages },
           status: :unprocessable_entity
  end

  def set_params
    params.require(:spot).permit(:name, :avatar_url, :gender, :province, :city, :spot_rating,
                                 :difficulty_rating, :spot_type, :default_image, :user_id,
                                 :geo_lat, :geo_lng, :address, :authentication_token, :remote_default_image_url)
  end
end

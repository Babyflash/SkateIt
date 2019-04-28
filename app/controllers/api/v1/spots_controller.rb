class Api::V1::SpotsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for Spot, except: [ :index ]

  respond_to :json

  def index
    @spots = Spot.all
    # .sort((a, b) => (a.spot_type > b.spot_type) ? 1 : ((b.spot_type > a.spot_type) ? -1 : 0))
    p "testing------------------"
    p params[:spot][:name]
    p "testing------------------"
    
    @allSpots = {}

    Spot.distinct.pluck(:spot_type).each do |type|
      @allSpots[type] = Spot.where(:spot_type => type ).order(created_at: :desc)
    end
  
    render json: @allSpots
  end

  def set_params
    params.require(:spot).permit(:name, :avatar_url, :gender, :province, :city)
  end
end

class Api::V1::SpotsController < Api::V1::BaseController
  respond_to :json

  def index
    @spots = Spot.all

    p "testing------------------"
    p params[:spot][:name]
    p "testing------------------"

    render json: @spots
  end

  def set_params
    params.require(:spot).permit(:name, :avatar_url, :gender, :province, :city)
  end
end

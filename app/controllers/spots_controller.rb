class SpotsController < ApplicationController
    before_action :load, only: [:show, :update, :edit, :destroy]

    # --- Create

    def new
        @spot = current_user.spots.new
        authorize @spot
    end

    def create
      @spot = current_user.spots.new(spot_params)
      @spot.spot_type = type(@spot.spot_type)
      authorize @spot

      if @spot.save
        redirect_to spot_path(@spot)
      else
        render 'new'
      end
    end

    # --- Read

    def index
      @allSpots = policy_scope(Spot).order(created_at: :desc)

      if params[:query].present?
         sql_query = "spot_type ILIKE :query"
        @spots = policy_scope(Spot).where(sql_query, query: "%#{params[:query]}%").order(created_at: :desc)
      else
        @spots = policy_scope(Spot).order(created_at: :desc)
      end

      @markers = @spots.map do |spot|
        {
          lat: spot.geo_lat,
          lng: spot.geo_lng,

          infoWindow: { content: render_to_string(partial: "/spots/map_window", locals: { spot: spot }) },
          image_url: helpers.asset_url('https://www.topdraw.com/assets/uploads/2016/05/66255487_thumbnail-591x640.png')
        }
      end
    end

    def show
      @post = Post.new
      @posts = Post.where(spot_id: params[:id])
      @content = PostContent.new
    end

    # --- Update

    def edit
    end

    def update
        @spot.update(spot_params)
        redirect_to '/spots'
    end

    def destroy
        @spot.destroy
        redirect_to '/spots'
    end

    private

    def load
        @spot = Spot.find(params[:id])
        authorize @spot
    end

    def spot_params
        params.require(:spot).permit(:spot_type, :difficulty_rating, :default_image, :geo_lng, :geo_lat, :query, :address)
    end

    def type(num)
      types = {
      '0' => "Ledge",
      '1' => "Rail",
      '2' => "Stair set",
      '3' => "Park",
      '4' => "Transition",
      '5' => "Manual pad"
      }
      types[num]
    end
end

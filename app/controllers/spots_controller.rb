class SpotsController < ApplicationController
    before_action :load, only: [:show, :update, :edit, :destroy]

    # --- Create

    def new
        @spot = current_user.spots.new
        authorize @spot
    end

    def create
      @spot = current_user.spots.new(spot_params)
      authorize @spot

      if @spot.save
        redirect_to spot_path(@spot)
      else
        render 'new'
      end
    end

    # --- Read

    def index
      @spots = policy_scope(Spot).order(created_at: :desc)

      @markers = @spots.map do |spot|
        {
          # lat: spot.geo_lat,
          # lng: spot.geo_lng
          lat: 47.9180385,
          lng: 106.9136493,

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
        params.require(:spot).permit(:spot_rating, :difficulty_rating, :default_image)
    end

end

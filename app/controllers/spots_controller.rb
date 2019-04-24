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

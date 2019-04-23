class SpotsController < ApplicationController
    before_action 
    
    # --- Create
    def new
        @spot = Spot.new
    end

    def create
        @spot = Spot.new(spot_params)
        @spot.user = current_user
        
        if @spot.save
            redirect_to spot_path(@spot)
        else
            render 'new'
        end
    end
    
    # --- Read
    def index
        @spots = Spot.all
    end

    def show
        @spot = Spot.find(params[:id])
    end

    private

    def load
        @spot = Spot.find(params[:id])
    end

    def spot_params
        params.require(:spot).permit(:spot_rating, :difficulty_rating, :default_image)
    end

end

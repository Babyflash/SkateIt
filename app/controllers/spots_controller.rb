class SpotsController < ApplicationController
    before_action :load, only: [:show, :update, :edit, :destroy]
    
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
    end

    def spot_params
        params.require(:spot).permit(:spot_rating, :difficulty_rating, :default_image)
    end

end

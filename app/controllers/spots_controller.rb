class SpotsController < ApplicationController
    before_action 
    
    # --- Create
    def new
    end

    def create
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
end

class SpotsController < ApplicationController
    
    # -- Read
    def index
        @spots = Spot.all
    end

    def show
    end

    private

    def load
        @spot = Spot.find(params[:id])
    end
end

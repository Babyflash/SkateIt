class SpotsController < ApplicationController
    before_action 
    # -- Read
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

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @spots = Spot.all
    @ledge_spots = Spot.where(:spot_type => 'Ledge').order(created_at: :desc);
    @rail_spots = Spot.where(:spot_type => 'Rail').order(created_at: :desc);
  end
end

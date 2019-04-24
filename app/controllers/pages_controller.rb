class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @spots = Spot.all
    @ledge_spots = Spot.where(:spot_type => '0');
    @rail_spots = Spot.where(:spot_type => '1');
  end
end

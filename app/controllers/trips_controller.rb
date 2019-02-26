class TripsController < ApplicationController

  def search
  end

  def index
    @trips = Trip.all
  end
end





class TripsController < ApplicationController

  def index
    @trips = Trip.all
    @trip = Trip.new
  end

  def search
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      redirect_to trips_path
    else
      render :new
    end
  end

  private

  def trip_params
    # params[:transport] = params[:transport].to_i
    params.require(:trip).permit(:transport, :start_time, :end_address, :started, :created_at, :updated_at)
  end
end



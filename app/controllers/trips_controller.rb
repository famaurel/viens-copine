class TripsController < ApplicationController

  def index
    @trip = Trip.new
    @trips = Trip.all
  end

  def show
    @trips = Trip.where.not(start_lat: nil, start_long: nil)
    @markers = @trips.map do |trip|
      {
        lng: trip.start_long,
        lat: trip.start_lat
      }
    end
  end

  def search
    @user = current_user
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
      if @booking.save
        redirect_to trips_path
      else
        render :index
      end
    else
      render :index
    end
  end

  private

  def trip_params
    # params[:transport] = params[:transport].to_i
    params.require(:trip).permit(:transport, :start_time, :end_address, :started, :created_at, :updated_at)
  end

end



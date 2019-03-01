class TripsController < ApplicationController

  def index
    @trip = Trip.new
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @marker = {
      lng: @trip.start_long,
      lat: @trip.start_lat
    }
    @bookings = @trip.bookings
  end

  def search
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
      @booking.update(creator: true)
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



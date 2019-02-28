class My::TripsController < ApplicationController

def index
    @trips = current_user.trips
    @bookings = current_user.bookings
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
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
end

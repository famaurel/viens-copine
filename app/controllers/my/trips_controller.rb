class My::TripsController < ApplicationController
  before_action :user_signed_in?

  def index
    @trips = current_user.trips
    @creator_bookings = Booking.where(user_id: current_user.id, creator: true)
    @pending_bookings = []
    @creator_bookings.each do |creator_booking|
      @pending_bookings << Booking.where(trip_id: creator_booking.trip_id, creator: false, progress: 0)
    end
    @pending_bookings = @pending_bookings.first
    @client_bookings = Booking.where(user_id: current_user.id, creator: false)
  end


  def destroy
    user = current_user
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path, notice: "Le trajet a été supprimé"
  end


end

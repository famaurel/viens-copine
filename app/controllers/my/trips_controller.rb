class My::TripsController < ApplicationController

  def index
    @creator_bookings = Booking.where(user_id: current_user.id, creator: true)
    @pending_bookings = []
    @creator_bookings.each do |creator_booking|
      @pending_bookings << Booking.where(trip_id: creator_booking.trip_id, creator: false, progress: 0)
    end
    @pending_bookings = @pending_bookings.first
    @client_bookings = Booking.where(user_id: current_user.id, creator: false)
  end
end

class My::BookingsController < ApplicationController
  def index

    @trips = current_user.trips
    @creator_bookings = Booking.where(user_id: current_user.id, creator: true)
    @pending_bookings = []
    @creator_bookings.each do |creator_booking|
      @pending_bookings << Booking.where(trip_id: creator_booking.trip_id, creator: false, progress: 0)
    end
    @pending_bookings = @pending_bookings.first

    # @pending_bookings = Booking.where(trip_id: @creator_bookings.map(&:trip_id), creator: false, progress: 0)

    @client_bookings = Booking.where(user_id: current_user.id, creator: false)
  end

  def show
    @booking = Booking.find(params[:id])
    @user = User.find(@booking.user_id)
    @trip = Trip.find(@booking.trip_id)
    @bookings = @trip.bookings

    @start_address = {
      lng: @trip.start_address.longitude,
      lat: @trip.start_address.latitude
    }
    @end_address = {
        lng: @trip.end_address.longitude,
        lat: @trip.end_address.latitude
    }
  end

  def approve
    @booking = Booking.find(params[:id])
    if @booking.update(state: "approved")
      @user = User.find(@booking.user_id)
      send_sms_accepted(@user)
    end
    respond_to do |format|
      format.html { redirect_to my_bookings_path }
      format.js
    end
  end

  def send_sms_accepted(user)
    @user_phone = "+33679480369"
    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    from = '+19796618636'
    to = '+33679480369'
    client.messages.create(
      from: from,
      to: to,
      body: "Votre réservation a bien été acceptée !"
    )
  end
end

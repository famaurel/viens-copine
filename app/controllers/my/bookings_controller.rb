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
  @user_phone = "+33685694571"
  client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  from = '+33644645152'
  to = @user_phone
  client.messages.create(
    from: from,
    to: to,
    body: "Votre réservation a bien été acceptée !"
    )
end

end

class My::BookingsController < ApplicationController

  def approve
    @booking = Booking.find(params[:id])
    if @booking.update(state: "approved")
      @user = User.find(@booking.user_id)
      send_sms_accepted(@user)
    end
    respond_to do |format|
           format.html { redirect_to my_trips_path }
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

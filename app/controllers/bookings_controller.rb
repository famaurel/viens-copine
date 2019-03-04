class BookingsController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
    if @booking.save
      @session_id = current_user.session_id
      require "opentok"
      opentok = OpenTok::OpenTok.new('46278222', 'd3a9a4c0cc104cdae7dd05881ee18115d487fc5e')
      session = opentok.create_session
      @publisher_token = session.generate_token
      @subscriber_token = session.generate_token
      @session_id = session.session_id
      @publisher_video_url = video_path + "?session_id=#{@session_id}&token=#{@publisher_token}"
      @subscriber_video_url = video_path + "?session_id=#{@session_id}&token=#{@subscriber_token}"
      UserMailer.booking(current_user, @trip, @subscriber_video_url).deliver_now
      redirect_to @publisher_video_url
      send_sms_to_creator(@trip, @subscriber_video_url)
      flash[:notice] = "Vous avez bien rejoint le trip 🙂 attente de la copine pour le chat"
    else
      redirect_to trips_path
      flash[:alert] = "Vous êtes déja dans ce trajet"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :trip_id, :creator, :progress, :state)
  end

  def send_sms_to_creator(trip, video_url)
    @video_url = video_url
    @creator = User.find(Booking.where(trip_id: @trip.id, creator: true).first.user_id)
    @creator.phone_number.slice!(0)
    @creator_phone = "+33" + @creator.phone_number
    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'],ENV['AUTH_TOKEN'])
    from = '+33644645152'
    to = @creator_phone
    client.messages.create(
    from: from,
    to: to,
    body: "Cliquez pour chater  http://0.0.0.0:3000/#{@video_url}"
    )
  end

end

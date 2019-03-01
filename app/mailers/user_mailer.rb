class UserMailer < ApplicationMailer

  def booking(current_user, trip, video_url)
    @video_url = video_url
    @current_user = current_user
    @trip = trip
    booking = Booking.where(trip_id: @trip.id, creator: true).first
    @user_trip_creator = User.find(booking.user_id)
    mail(to: @user_trip_creator.email, subject: @current_user.email + 'veut rejoindre votre groupe')
  end


end

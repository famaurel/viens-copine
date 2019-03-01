class BookingsController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
    if @booking.save
      redirect_to video_path(@trip.id, :foo => params[:foo])
      flash[:notice] = "Vous avez bien rejoint le trip 🙂"
    else
      redirect_to trips_path
      flash[:alert] = "Vous êtes déja dans ce trajet"
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:user_id, :trip_id, :creator, :progress, :state)
  end
end

class BookingsController < ApplicationController

  def create
    @trip = Trip.find(params[:id])
    @booking = @user.booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to trips_path
    else
      render :new
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:user_id, :trip_id, :creator, :progress, :state)
  end
end


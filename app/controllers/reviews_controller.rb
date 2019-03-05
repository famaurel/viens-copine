class ReviewsController < ApplicationController

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(@booking)
  end

  def create
    @booking = Booking.find(params[:booking_id])

    if @booking.update(review_params)
      redirect_to bookings_path
    else
      render :new
    end
  end

private
  def review_params
    params.require(:booking).permit(:review, :rating)
  end

end

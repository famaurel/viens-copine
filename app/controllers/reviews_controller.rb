class ReviewsController < ApplicationController

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(booking_id: @booking.id)
  end

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @review.user = current_user
    @review.booking = @booking
    if @review.save
      redirect_to trips_path
    else
      render :new
    end
  end

private
  def review_params
    params.require(:review).permit(:content, :rating)
  end

end




#  def create
#    @sale = Sale.new(sale_params)
#    @sale.contact = Contact.find(params[:contact_id])
#    if @sale.save
#      redirect_to contact_path(params[:contact_id])
#    else
#      render :new
#    end
#  end



#  private

#  def sale_params
#    params.require(:sale).permit(:value, :amount)
#  end


# end

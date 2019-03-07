class My::TripsController < ApplicationController
  before_action :user_signed_in?

  def destroy
    user = current_user
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_search_path, notice: "Le trajet a été supprimé"
  end

  def index
    @user = current_user
    @trips = Trip.all
  end

  def create
    @start_address = Address.create!(title: params[:search][:start_address], state: 0)
    @end_address = Address.create!(title: params[:search][:end_address], state: 1)
    @trip = Trip.new(transport: params[:search][:transport].last.to_i,
     start_time: Time.now + 60 * params[:search][:start_time].last.to_i)
    @trip.start_address = @start_address
    @trip.end_address = @end_address
    if @trip.save
    # format.js {redirect_to trips_path(@album)}
      @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
      @booking.update(creator: true)

      redirect_to my_trips_path

      if @booking.save
      else
        render :index
      end
    else
      render :index
    end
  end



end

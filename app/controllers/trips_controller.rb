class TripsController < ApplicationController

  def index
    @trip = Trip.new

    if params[:search].present?
      start_addresses_id = Address.near(params[:search][:start_address], 10).map(&:id)
      end_addresses_id = Address.near(params[:search][:end_address], 10).map(&:id)
      @trips = Trip.where(start_address_id: start_addresses_id, end_address_id: end_addresses_id)
    else
      @trips = Trip.all
    end
  end

  def search
    @user = current_user
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @booking = Booking.new(user_id: current_user.id, trip_id: @trip.id)
      if @booking.save
        redirect_to trips_path
      else
        render :index
      end
    else
      render :index
    end
  end

  private

  def trip_params
    # params[:transport] = params[:transport].to_i
    params.require(:trip).permit(:transport, :start_time, :end_address, :started, :created_at, :updated_at)
  end

end



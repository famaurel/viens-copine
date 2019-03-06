class TripsController < ApplicationController
  def index
    if params[:search].present?
      start_addresses_ids = Address.near(params[:search][:start_address], 0.5).map(&:id)
      end_addresses_ids = Address.near(params[:search][:end_address], 0.5).map(&:id)
      start_time = (Time.now + 60 * params[:search][:start_time][1].to_i).to_i
      transport = params[:search][:transport][1].to_i

      @trips = Trip.where(start_address_id: start_addresses_ids,
                          end_address_id: end_addresses_ids,
                          transport: transport).where("start_time > ?", [(start_time) - (60*10)])
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @start_address = {
      lng: @trip.start_address.longitude,
      lat: @trip.start_address.latitude
    }
    @end_address = {
        lng: @trip.end_address.longitude,
        lat: @trip.end_address.latitude
    }

    @bookings = @trip.bookings
  end

  def search
  end

  def create
    @start_address = Address.create!(title: params[:search][:start_address], state: 0)
    @end_address = Address.create!(title: params[:search][:end_address], state: 1)
    @trip = Trip.new(transport: params[:search][:transport].last.to_i,
                     start_time: Time.now + 60 * params[:search][:start_time].last.to_i)
    @trip.start_address = @start_address
    @trip.end_address = @end_address
    if @trip.save
      @booking = Booking.create(user_id: current_user.id, trip_id: @trip.id, creator: true)
      redirect_to my_bookings_path
    else
      render :index
    end
  end

  private

  def trip_params
    # params[:transport] = params[:transport].to_i
    params.require(:search).permit(:transport, :start_time, :started)
  end
end


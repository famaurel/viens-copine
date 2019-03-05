class My::TripsController < ApplicationController
  before_action :user_signed_in?

  def destroy
    user = current_user
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path, notice: "Le trajet a été supprimé"
  end

end

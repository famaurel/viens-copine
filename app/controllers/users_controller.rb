class UsersController < ApplicationController

  def geocoded_address
    @lng = params[:lng]
    @lat = params[:lat]
    results = Geocoder.search([@lat, @lng])
    @data = { address: results.first.address }
  end
end

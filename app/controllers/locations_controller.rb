class LocationsController < ApplicationController
  def create
    trip_id = params[:trip_id]
    @trip = Rails.cache.read ("trips/#{trip_id}")
    # @trip = Rails.cache.fetch("trips/#{trip_id}" , expires_in: 1.day) do
    #   Trip.find(trip_id)
    # end
    if @trip
      @trip.locations.new(params.require(:location).permit(:longitude , :latitude))
      Rails.cache.write("trips/#{trip_id}" , @trip, expires_in: 1.day)
      render json: {message: "location inserted into Trip cached object"}
    else
      render json: {message: "error this Trip is not in ongoing state"}
    end
  end
end

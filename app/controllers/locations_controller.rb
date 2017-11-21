class LocationsController < ApplicationController
  def create
    trip_id = params[:trip_id]
    @trip = Rails.cache.fetch("trips/#{trip_id}" , expires_in: 1.day) do
      Trip.find(trip_id)
    end
    @trip.locations.new(params.require(:location).permit(:longitude , :latitude))
    Rails.cache.write("trips/#{trip_id}" , @trip, expires_in: 1.day)
    render json: {message: "location inserted into Trip cached object"}
  end
end

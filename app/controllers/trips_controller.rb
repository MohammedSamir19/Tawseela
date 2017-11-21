class TripsController < ApplicationController
  def index
     @trips = Trip.all
     render json: @trips.as_json(except: :updated_at ,include: {startpoint: {except: :updated_at} , endpoint: {except: :updated_at}})
  end

  def create
    @trip = Trip.new(params.require(:trip).permit(:status))
    @trip.startpoint = Location.create(params.require(:startpoint).permit(:longitude, :latitude))
    @trip.endpoint = Location.create(params.require(:endpoint).permit(:longitude, :latitude))
    if @trip.save
      render json: @trip
    else
      render json: {id: -1}
    end
  end

  def show
    @trip = Trip.find(params[:id])
    render json: @trip.as_json(except: :updated_at ,include: {startpoint: {except: :updated_at} , endpoint: {except: :updated_at} , locations:{except: [:updated_at , :created_at]} } )
  end

  def update
    trip_id = params[:id]
    @trip = Trip.find(trip_id)
    if @trip.update(params.require(:trip).permit(:status))
      if @trip.status == "ended"
        TripWorker.perform_async("trips/#{trip_id}")
      elsif @trip.status == "ongoing"
        Rails.cache.write("trips/#{trip_id}",@trip, expires_in: 1.day)
      else
        Rails.cache.delete("trips/#{trip_id}")
      end
      render json: {updated: true}
    else
      render json: {updated: false}
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    if @trip.destroy
      render json: {deleted: true}
    else
      render json: {deleted: false}
    end
  end




end

class TripWorker
  include Sidekiq::Worker

def perform(trip_id)
  @trip = Rails.cache.read(trip_id)
  if @trip
    @trip.locations.each(&:save)
    Rails.cache.delete("trips/#{trip_id}")
    puts "Sidekiq insert locations to database"
  end
end

end

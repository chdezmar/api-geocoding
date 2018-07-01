class LocationsGeocoderWorker
  include Sidekiq::Worker

  class GeocodingError < StandardError; end

  def perform(location_id)
    geocode_response = LocationsGeocoder.call(location_id)

    if geocode_response.code == '200'
      location = Location.find(location_id)
      latitude = JSON.parse(geocode_response.body).with_indifferent_access[:results][0][:geometry][:location][:lat]
      longitude = JSON.parse(geocode_response.body).with_indifferent_access[:results][0][:geometry][:location][:lng]
      location.update!(latitude: latitude, longitude: longitude)
    else
      raise GeocodingError, "Geocoding Unsuccessful"
    end

  end
end

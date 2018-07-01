class Location < ApplicationRecord
  after_create :geocode

  private

  def geocode
    LocationsGeocoderWorker.perform_async(self.id) unless self.latitude && self.longitude
  end
end

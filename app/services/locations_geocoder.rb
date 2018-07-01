require 'uri'
require 'net/http'

class LocationsGeocoder

  API_KEY = ENV['GOOGLE_GEOCODING_API']
  BASE_URL = 'https://maps.googleapis.com/maps/api/geocode/json'

  def self.call(id, options = {})
    location = Location.find(id)

    url = URI("#{BASE_URL}?address=#{location.address}&components=country:#{location.country}&key=#{API_KEY}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)

    response = http.request(request)

    # latitude = JSON.parse(response.body).with_indifferent_access[:results][0][:geometry][:location][:lat]
    # longitude = JSON.parse(response.body).with_indifferent_access[:results][0][:geometry][:location][:lat]
  end
end

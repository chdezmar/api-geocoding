require 'rails_helper'

RSpec.describe Api::LocationsController, type: :controller do

  describe "POST create" do

    before do
       create_location_params
    end

    it "creates a new location" do
      post :create, params: { location: @starbucks_madrid_not_geocoded }
      expect(response).to have_http_status(:created)
      location = Location.last
      expect(location.name).to eq("Starbucks")
      expect(location.phone).to eq("+34 915 21 29 02")
      expect(location.address).to eq("Calle del Arenal, 14")
      expect(location.postcode).to eq("28013")
      expect(location.city).to eq("Madrid")
      expect(location.country).to eq("ES")
    end
  end

  private

  def create_location_params
    JSON.parse(file_fixture("locations.json").read, symbolize_names: true).each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

end

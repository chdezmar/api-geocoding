class Api::LocationsController < ApplicationController

  def create
    location = Location.create(location_params)
    render json: location, status: :created
  end

  private

  def location_params
    params
      .require(:location)
      .permit( :name, :phone, :address, :postcode, :city, :country, :latitude, :longitude)
  end
end

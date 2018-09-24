require_relative 'geocoding'

class Address
  attr_accessor :lat, :lng, :full_address   

  def geocode
    Geocoder.coordinates(full_address)
  end

  def reverse_geocode
    Geocoder.address([lat, lng])
  end

  def distance_from_dc
    Geocoder::Calculations.distance_between([lat,lng], dc_cordinates)
  end

  def dc_cordinates
    Geocoder.coordinates("1600 Pennsylvania Avenue NW Washington, D.C. 20500")
  end
end

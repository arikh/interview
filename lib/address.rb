require_relative 'geocoding'

class Address

  attr_accessor :lat, :lng, :full_address   

  def geocode
    coords = Geocoder.coordinates(full_address)
    @lat = coords[0]
    @lng = coords[1]
    coords
  end

  def reverse_geocode
    address = Geocoder.address([lat, lng])
    @full_address = address
    address
  end  

  def coordinates
    [lat,lng]
  end
  
  def distance(other_coordinates)
    Geocoder::Calculations.distance_between(coordinates, other_coordinates)
  end

  def miles_to(other_address)
    distance other_address.coordinates
  end

  def distance_from_dc
    distance dc_cordinates
  end

  def dc_cordinates
    Geocoder.coordinates("1600 Pennsylvania Avenue NW Washington, D.C. 20500")
  end  

  def geocoded?
    !lat.nil? and !lng.nil?
  end

  def reverse_geocoded?
    !full_address.nil?
  end

end

require 'sinatra/base'
Dir['./lib/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do  
    
    LAT_LONG = [
      [61.582195,-149.443512],
      [44.775211, -68.774184],
      [25.891297, -97.393349],
      [45.787839, -108.502110],
      [35.109937, -89.959983],
    ].freeze

    records = []

    add_obj = Address.new

    LAT_LONG.each do |coord|        
        add_obj.lat = coord[0]
        add_obj.lng = coord[1]
        records.push([
          coord.join(","),
          add_obj.reverse_geocode,
          add_obj.distance_from_dc 
          ])
    end 
    
    records.sort_by!(&:last)

    erb :index , locals: { results: records}
  end

  get '/test' do 
    add_obj = Address.new
    # add_obj.lat = 40.181306
    # add_obj.lng = -80.265949
    # add_obj.reverse_geocode

    add_obj.full_address = '1600 Pennsylvania AVE, WASHINGTON, PA 20500, United States'
    add_obj.geocode
    erb :test , locals: { results: add_obj.geocoded?}
  end
end

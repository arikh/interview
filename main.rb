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

end

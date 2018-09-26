RSpec.describe Address do
  let(:full_address) { "1600 Pennsylvania AVE, WASHINGTON, PA 20500, United States" }

  let(:lat) { 40.181306 }
  let(:lng) { -80.265949 }

  subject(:address) { described_class.new }

  describe 'geocoding' do

    let(:result) { [lat, lng] }

    it 'geocodes with Geocoder API' do
      address.full_address = full_address
      expect(Geocoder).to receive(:coordinates).with(full_address).and_return result
      address.geocode      
    end

    it 'is geocoded' do 
      address.full_address = full_address
      address.geocode    

      expect(address).to be_geocoded
    end
  end

  describe 'reverse geocoding' do
        
    let(:result) { "1600 Pennsylvania AVE, WASHINGTON, PA 20500, United States" }

    it 'reverse geocodes with Geocoder API' do
      address.lat = lat
      address.lng = lng       
      expect(Geocoder).to receive(:address).with([lat,lng]).and_return result
      address.reverse_geocode
    end

    it 'is reverse geocoded' do
      address.lat = lat
      address.lng = lng
      address.reverse_geocode
      expect(address).to be_reverse_geocoded
    end
  end

  describe 'distance finding' do
    let(:detroit) { FactoryGirl.build :address, :as_detroit }
    let(:kansas_city) { FactoryGirl.build :address, :as_kansas_city }

    it 'calculates distance with the Geocoder API' do
      expect(Geocoder::Calculations).to receive(:distance_between).with detroit.coordinates, kansas_city.coordinates
      detroit.distance kansas_city.coordinates
    end

    it 'returns the distance between two addresses' do
      expect(detroit.miles_to(kansas_city)).to be > 0
      detroit.miles_to kansas_city
    end
  end
end

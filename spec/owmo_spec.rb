require "spec_helper"

RSpec.describe OWMO do
  it "has a version number" do
    expect(OWMO::VERSION).not_to be nil
  end

  describe "#weather" do
    it "returns Weather object" do
      OWMO::weather(@api_key).is_a? OWMO::Weather
    end
    it "yields Weather object" do
      OWMO::weather(@api_key) { |weather| weather.is_a? OWMO::Weather}
    end
  end
end


RSpec.describe OWMO::Weather do

  describe "#initialize" do
    it "returns Weather object" do
      OWMO::Weather.new(@api_key).is_a? OWMO::Weather
    end
    it "yields Weather object" do
      OWMO::Weather.new(@api_key) { |weather| weather.is_a? OWMO::Weather}
    end
  end # initialize

  describe "#get" do
    let(:api_key) { 'd33b4df8a76def8a9846d6dc1a5c9fa9' }
    let(:weather) { OWMO::weather(api_key) }
    let(:params) {
      {
        city_name: "Cedar Rapids",
        city_id: 4850751,
        zip: 52401,
        lat: 42.01,
        lon: -91.64,
        cities: [4850751,4887398,2643743,4164138,5368361]
      }
    }

    context ':group' do
      context 'multiple ids' do
        it 'by :id' do
          data = weather.get :group, id: params[:cities].join(',')
          expect(data['cnt']).to eq(params[:cities].size)
        end
        it 'by :city_id' do
          data = weather.get :group, city_id: params[:cities].join(',')
          expect(data['cnt']).to eq(params[:cities].size)
        end
      end
    end

    context ':current' do
      context 'city name' do
        it 'by :q' do
          data = weather.get :current, q: params[:city_name]
          expect(data['name']).to eq(params[:city_name])
        end
        it 'by :city_name' do
          data = weather.get :current, city_name: params[:city_name]
          expect(data['name']).to eq(params[:city_name])
        end
      end
      context 'city id' do
        it 'by :id' do
          data = weather.get :current, id: params[:city_id]
          expect(data['name']).to eq(params[:city_name])
        end
        it 'by :city_id' do
          data = weather.get :current, city_id: params[:city_id]
          expect(data['name']).to eq(params[:city_name])
        end
      end
      context 'zip code' do
        it 'by :zip' do
          data = weather.get :current, zip: params[:zip]
          expect(data['name']).to eq(params[:city_name])
        end
        it 'by :zip_code' do
          data = weather.get :current, zip_code: params[:zip]
          expect(data['name']).to eq(params[:city_name])
        end
      end
      context 'coordinance' do
        it 'by :lat and :lon' do
          data = weather.get :current, lat: params[:lat], lon: params[:lon]
          expect(data['name']).to eq(params[:city_name])
        end
      end
    end

    context ':forecast5' do
      context 'city name' do
        it 'by :q' do
          data = weather.get :forecast5, q: params[:city_name]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :city_name' do
          data = weather.get :forecast5, city_name: params[:city_name]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'city id' do
        it 'by :id' do
          data = weather.get :forecast5, id: params[:city_id]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :city_id' do
          data = weather.get :forecast5, city_id: params[:city_id]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'zip code' do
        it 'by :zip' do
          data = weather.get :forecast5, zip: params[:zip]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :zip_code' do
          data = weather.get :forecast5, zip_code: params[:zip]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'coordinance' do
        it 'by :lat and :lon' do
          data = weather.get :forecast5, lat: params[:lat], lon: params[:lon]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
    end

    context ':forecast16' do
      context 'city name' do
        it 'by :q' do
          data = weather.get :forecast16, q: params[:city_name]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :city_name' do
          data = weather.get :forecast16, city_name: params[:city_name]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'city id' do
        it 'by :id' do
          data = weather.get :forecast16, id: params[:city_id]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :city_id' do
          data = weather.get :forecast16, city_id: params[:city_id]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'zip code' do
        it 'by :zip' do
          data = weather.get :forecast16, zip: params[:zip]
          expect(data['city']['name']).to eq(params[:city_name])
        end
        it 'by :zip_code' do
          data = weather.get :forecast16, zip_code: params[:zip]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
      context 'coordinance' do
        it 'by :lat and :lon' do
          data = weather.get :forecast16, lat: params[:lat], lon: params[:lon]
          expect(data['city']['name']).to eq(params[:city_name])
        end
      end
    end

  end
end

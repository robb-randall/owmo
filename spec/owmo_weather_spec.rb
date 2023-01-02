# frozen_string_literal: true

require 'json'
require 'spec_helper'


RSpec.describe OWMO::Weather do
  describe '#initialize' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns Weather object' do
      OWMO::Weather.new(api_key).is_a? OWMO::Weather
    end
    it 'yields Weather object' do
      OWMO::Weather.new(api_key) { |weather| weather.is_a? OWMO::Weather }
    end
  end

  describe '#get' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns weather json' do

      weather_json = {
        "coord": {
          "lon": 10.99,
          "lat": 44.34
        },
        "weather": [
          {
            "id": 501,
            "main": "Rain",
            "description": "moderate rain",
            "icon": "10d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 298.48,
          "feels_like": 298.74,
          "temp_min": 297.56,
          "temp_max": 300.05,
          "pressure": 1015,
          "humidity": 64,
          "sea_level": 1015,
          "grnd_level": 933
        },
        "visibility": 10000,
        "wind": {
          "speed": 0.62,
          "deg": 349,
          "gust": 1.18
        },
        "rain": {
          "1h": 3.16
        },
        "clouds": {
          "all": 100
        },
        "dt": 1661870592,
        "sys": {
          "type": 2,
          "id": 2075663,
          "country": "IT",
          "sunrise": 1661834187,
          "sunset": 1661882248
        },
        "timezone": 7200,
        "id": 3163858,
        "name": "Zocca",
        "cod": 200
      }

      owmo = OWMO::Weather.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_json)

      expect(owmo.get(:current, city_name: "London,UK")).to eq(weather_json)
      expect(owmo.get(:current, city_id: 5328041)).to eq(weather_json)
      expect(owmo.get(:current, id: 5328041)).to eq(weather_json)
      expect(owmo.get(:current, city_name: "Beverly Hills")).to eq(weather_json)
      expect(owmo.get(:current, q: "Beverly Hills")).to eq(weather_json)
      expect(owmo.get(:current, zip: 90210)).to eq(weather_json)
      expect(owmo.get(:current, zip_code: 90210)).to eq(weather_json)
      expect(owmo.get(:current, lon: -118.41, lat: 34.09)).to eq(weather_json)
    end

    it 'throws WeatherResponseError exception when provided an invalid API key' do

      weather_json = {
        "cod":401,
        "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info."
      }

      owmo = OWMO::Weather.new('invalid api_key')
      allow(owmo).to receive(:http_get).and_return(weather_json)

      expect{owmo.get(:current, city_name: "London,UK")}.to raise_error(OWMO::Weather::WeatherResponseError)
    end

  end

end

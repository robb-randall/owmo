# frozen_string_literal: true

require 'net/http'
require 'json'
require 'spec_helper'

RSpec.describe OWMO::Weather do
  describe '#initialize' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns Weather object' do
      described_class.new(api_key).is_a? described_class
    end

    it 'yields Weather object' do
      described_class.new(api_key) { |weather| weather.is_a? described_class }
    end
  end

  describe '#get' do
    let(:api_key) { '12345678901234567890123456789012' }
    let(:weather_response) { Net::HTTPResponse.new(1.0, 200, 'OK') }
    let(:valid_weather_json) { '{ "cod": "200", "message": "This is an example message text" }' }
    let(:invalid_weather_json) { '{ "cod": "400", "message": "This is an example message text" }' }

    it 'returns weather json' do
      allow(weather_response).to receive(:body).and_return(valid_weather_json)

      owmo = described_class.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect(owmo.get(:current, city_name: 'London,UK')).to eq(JSON.parse(valid_weather_json))
    end

    it 'throws WeatherResponseError exception when provided an invalid API key' do
      allow(weather_response).to receive(:body).and_return(invalid_weather_json)

      owmo = described_class.new('invalid api_key')
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect { owmo.get(:current, city_name: 'London,UK') }.to raise_error(OWMO::Weather::WeatherResponseError)
    end
  end
end

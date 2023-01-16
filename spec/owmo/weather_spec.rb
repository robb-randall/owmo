# frozen_string_literal: true

require 'net/http'
require 'json'
require 'spec_helper'

RSpec.describe OWMO::Weather do
  describe '#get' do
    let(:api_key) { '12345678901234567890123456789012' }
    let(:weather_response) { Net::HTTPResponse.new(1.0, 200, 'OK') }

    it 'returns weather json when `cod` is present in the response' do
      valid_weather_json = '{ "cod": "200", "message": "This is an example message text" }'
      allow(weather_response).to receive(:body).and_return(valid_weather_json)

      owmo = described_class.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect(owmo.get(:current, city_name: 'London,UK')).to eq(JSON.parse(valid_weather_json))
    end

    it 'returns weather json when `cnt` is present in the response' do
      valid_weather_json = '{ "cnt": 10, "message": "This is an example message text" }'
      allow(weather_response).to receive(:body).and_return(valid_weather_json)

      owmo = described_class.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect(owmo.get(:current, city_name: 'London,UK')).to eq(JSON.parse(valid_weather_json))
    end

    it 'returns weather xml' do
      valid_weather_xml = '<?xml version=\"1.0\" encoding=\"UTF-8\"?><current></current>'
      allow(weather_response).to receive(:body).and_return(valid_weather_xml)

      owmo = described_class.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect(owmo.get(:current, city_name: 'London,UK')).to eq(valid_weather_xml)
    end

    it 'returns weather html' do
      valid_weather_html = '<?xml version=\"1.0\" encoding=\"UTF-8\"?><current></current>'
      allow(weather_response).to receive(:body).and_return(valid_weather_html)

      owmo = described_class.new(api_key)
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect(owmo.get(:current, city_name: 'London,UK')).to eq(valid_weather_html)
    end

    it 'throws WeatherResponseError exception when provided an invalid API key' do
      invalid_weather_json = '{ "cod": "400", "message": "This is an example message text" }'
      allow(weather_response).to receive(:body).and_return(invalid_weather_json)

      owmo = described_class.new('invalid api_key')
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect { owmo.get(:current, city_name: 'London,UK') }.to raise_error(OWMO::Weather::WeatherResponseError)
    end

    it 'throws WeatherResponseError exception when response does not include `cod` or `cnt`' do
      invalid_weather_json = '{ "message": "This is an example message text" }'
      allow(weather_response).to receive(:body).and_return(invalid_weather_json)

      owmo = described_class.new('invalid api_key')
      allow(owmo).to receive(:http_get).and_return(weather_response)

      expect { owmo.get(:current, city_name: 'London,UK') }.to raise_error(OWMO::Weather::WeatherResponseError)
    end
  end
end

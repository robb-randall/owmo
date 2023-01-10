# frozen_string_literal: true

require 'json'
require 'net/http'

module CoreExtensions
  module Net
    module HTTPResponse
      module WeatherResponse
        # rdoc
        # Returns the weather
        def weather
          parse_weather
          @weather
        end

        # rdoc
        # Returns the response code
        def weather_code
          parse_weather

          return (weather['cod'] || '500').to_i if weather.is_a? Hash

          200
        end

        # rdoc
        # Returns the response message
        def weather_message
          parse_weather
          return weather['message'] if weather.is_a? Hash

          'None'
        end

        # rdoc
        # Returns boolean if the response contains an error or not.
        def error?
          weather_code != 200
        end

        private

        # rdoc
        # Sets the weather variable
        def weather=(weather)
          @weather = weather if @weather.nil?
        end

        # rdoc
        # Attempts to parse the body to JSON.  This is so we don't have to continually
        # parse the raw JSON.
        def parse_weather
          # Try to parse the response and return a hash
          @weather = JSON.parse(body)
        rescue StandardError
          # Return the body string if parsing fails (used for html and xml responses)
          @weather = body
        end
      end
    end
  end
end

Net::HTTPResponse.include CoreExtensions::Net::HTTPResponse::WeatherResponse

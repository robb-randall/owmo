require 'json'

module CoreExtensions
  module Net
    module HTTPResponse
      module WeatherResponse

=begin rdoc
Returns the weather
=end
        def weather
          parse_weather
          @weather
        end

=begin rdoc
Returns the response code
=end
        def weather_code
          parse_weather
          return (weather['cod'] || "200").to_i if weather.is_a? Hash
          200
        end

=begin rdoc
Returns the response message
=end
        def weather_message
          parse_weather
          return weather['message'] if weather.is_a? Hash
          "None"
        end

=begin rdoc
Returns boolean if the response contains an error or not.
=end
        def has_error?
          weather_code != 200
        end

        private

=begin rdoc
Sets the weather variable
=end
          def weather=(weather)
            @weather = weather if @weather.nil?
          end

=begin rdoc
Attempts to parse the body to JSON.  This is so we don't have to continually
parse the raw JSON.
=end
          def parse_weather
            begin
              # Try to parse the response and return a hash
              @weather = JSON.parse(self.body)
            rescue
              # Return the body string if parsing fails (used for html and xml responses)
              @weather = self.body
            end
          end

      end
    end
  end
end

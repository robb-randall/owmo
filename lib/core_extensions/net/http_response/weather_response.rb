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
        end # weather

=begin rdoc
Returns the response code
=end
        def weather_code
          parse_weather
          return (@weather['cod'] || "200").to_i if @weather.is_a? Hash
          200
        end

=begin rdoc
Returns the response message
=end
        def weather_message
          parse_weather
          return @weather['message'] if @weather.is_a? Hash
          ""
        end

=begin rdoc
Returns boolean if the response contains an error or not.
=end
        def has_error?
          weather_code != 200
        end # has_error?

=begin rdoc
Attempts to parse the body to JSON.  This is so we don't have to continually
parse the raw JSON.
=end
        private
        def parse_weather
          begin
            @weather = JSON.parse(self.body)
          rescue
            @weather = self.body
          end if @weather.nil?
        end # parse_weather

      end # WeatherResponse
    end # HTTPResponse
  end # Net
end # CoreExtensions

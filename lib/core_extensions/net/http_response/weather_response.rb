require 'json'


module CoreExtensions
  module Net
    module HTTPResponse
      module WeatherResponse
=begin rdoc
Contains the weather data.  If it's JSON, then it'll be a hash, other forms (XML, HTML)
will be raw format.  The raw JSON is also available using the self.body.
=end
        attr_reader :weather

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
        public
        def weather_code
          parse_weather
          return @weather['cod'].to_i if @weather.is_a? Hash
          200
        end # weather_error

=begin rdoc
Returns the response message
=end
        public
        def weather_message
          parse_weather
          return @weather['message'] if @weather.is_a? Hash
          ""
        end # weather_message

=begin rdoc
Returns boolean if the response contains an error or not.
=end
        public
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

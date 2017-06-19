
module ApiExceptions

=begin rdoc
Weather response error to handle errors received from OpenWeatherMap.orgs API
=end
    class WeatherResponseError < StandardError
      def initialize(response)
        @response = response
        super("ERROR #{@response.weather_code}: #{@response.weather_message}")
      end # initialize
    end # WeatherResponseError

end # ApiExceptions

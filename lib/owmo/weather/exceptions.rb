module WeatherExceptions

=begin rdoc
Invalid path specified
=end
  class InvalidPathSpecified < StandardError
    def initialize(path=nil)
      @path = path
      super("Invalid path specified: Got: '#{@path}', expected one of: #{Paths.keys}")
    end
  end

=begin rdoc
Missing Geocode from query
=end
  class MissingGeocodes < StandardError
  end

=begin rdoc
Weather response error to handle errors received from OpenWeatherMap.orgs API
=end
  class WeatherResponseError < StandardError
    def initialize(response)
      @response = response
      super("ERROR #{@response.weather_code}: #{@response.weather_message}")
    end
  end

end

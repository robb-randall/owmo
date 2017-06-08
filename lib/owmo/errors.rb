module OWMO

=begin rdoc
Generic OWMO error
=end
  class OWMOError < StandardError
  end # OWMOError

=begin rdoc
Generic OWMO::Weather class error
=end
  class WeatherError < OWMOError
  end # WeatherError

=begin rdoc
Raised when missing OpenWeatherMap.org API key
=end
  class MissingApiKey < WeatherError
    def initialize()
      super("Missing OpenWeatherMap.org API key, please register for one here -> http://openweathermap.org/appid")
    end # initialize
  end # MissingApiKey

=begin rdoc
Raised when invalid API key is specified
=end
class InvalidApiKey < WeatherError
  def initialize(api_key = nil)
    @api_key = api_key
    super("Invalid API key specified: '#{api_key}'")
  end # initialize
end # MissingApiKey

=begin rdoc
Invalid path specified
=end
  class InvalidPathSpecified < WeatherError
    def initialize(msg = nil, path = nil)
      @path = path
      super(msg)
    end # initialize
  end # NoGeocodeSpecified

=begin rdoc
Raised when an invalid Geocode is specified
=end
  class InvalidGeocodeSpecified < InvalidPathSpecified
    def initialize(msg = nil, path = nil, **query = nil)
      @query = query
      super(msg = msg, path = path)
    end # initialize
  end # NoGeocodeSpecified


end # OWMO

require 'owmo/api'
require 'owmo/weather/exceptions'
require 'owmo/weather/parameters'

require 'set'
require 'uri'


module OWMO

=begin rdoc
A weather class for retrieving current and forecasted weather conditions.
==== Attributes
* +api_key+ - {OpenWeatherMap.org API key}[http://openweathermap.org/appid]
==== Examples
  api_key = "<My API Key>"
  weather = OWMO::Weather.new api_key: api_key
  puts weather.get :current, city_name: "London,uk"

=end
  class Weather
    include WeatherExceptions
    include WeatherParameters
    include WeatherAPI

    attr_reader :api_key, :Paths, :Geocodes

    def initialize(api_key, **kwargs) #:notnew:
      @api_key = api_key

      yield self if block_given?
    end # initialize

=begin rdoc
A weather class for retrieving current and forecasted weather conditions.
==== Attributes
* +path+ - OWMO::Wether.Path parameter
* +query+ - Hash of query options (Geocode, response format, units, etc.)
==== Examples
  api_key = "<My API Key>"
  weather = OWMO::Weather.new api_key: api_key
  puts weather.get :current, city_name: "London,uk"
=end
    public
    def get(path, **query)
      # Format Geocode info
      query = check_geocodes query

      # Add the api key
      query[:APPID] = @api_key

      # Create the uri
      raise InvalidPathSpecified.new(path) if Paths[path].nil?
      uri = URI "#{OWMO::URL}/#{Paths[path]}?#{URI.encode_www_form(query)}"

      # Get the weather data
      get_weather(uri)

    end # get

=begin rdoc
Ensure appropriate query options are applied to the final URI
=end
  def check_geocodes(**query)

    # May never be called since query is required
    raise MissingGeocodes if query.size == 0

    Geocodes.each do |name, geocodes|

      # Get the common keys
      intersect = geocodes[:options].flatten & query.keys

      # If there are common keys
      if intersect.size > 0 then

        # Remap any keys if they are not the same as the query
        case geocodes[:query]
        when Array then
          intersect.zip(geocodes[:query]).each do |old_key, new_key|
            query[new_key] = query.delete(old_key) unless new_key == old_key
          end # intersect
        else
          query[geocodes[:query]] = query.delete(intersect[0]) unless geocodes[:query] == intersect[0]
        end # case

        return query
      end # if

    end # GEOCODES

    raise MissingGeocodes
  end # check_geocodes

  end # Weather
end # OWMO

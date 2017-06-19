require 'owmo/weather/exceptions'

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

    attr_reader :api_key, :Paths, :Geocodes

=begin rdoc
Access current or forecasted conditions by (required):
* +:current+ - {Current weather data}[http://openweathermap.org/current]
* +:forecast5+ - {5 day / 3 hour forecast}[http://openweathermap.org/forecast5]
* +:forecast16+ - {16 day / daily forecast}[http://openweathermap.org/forecast16]
=end
    Paths = {
      current: 'weather', # Current weather data
      forecast5: 'forecast', # 5 day / 3 hour forecast
      forecast16: 'forecast/daily' # 16 day / daily forecast
    }

=begin rdoc
{Geocode options (required):}[http://openweathermap.org/current#one]
* +q:+ or +city_name:+ - By city name
* +id:+ or +city_id:+ - By city ID
* +zip:+ or +zip_code:+ - By zip code
* +lat:+, +lon:+ or +latitude:+, +longitude:+ - By geographic coordinates
=end
    Geocodes = {
      "City Name" => {
        query: :q,
        options: [:q, :city_name]
      },
      "City ID" => {
        query: :id,
        options: [:id, :city_id]
      },
      "Zip Code" => {
        query: :zip,
        options: [:zip, :zip_code]
      },
      "Coordinance" => {
        query: [:lat, :lon],
        options: [[:lat, :lon], [:lattitude, :longitude]]
      },
      "Cities Within a Rectangle Zone" => {
        query: :bbox,
        options: [:bbox]
      },
      "Cities Within a Circle" => {
        query: [:lat, :lon, :cnt],
        options: [[:lat, :lon, :cnt],[:lattitude, :longitude, :cnt]]
      }
    }

    def initialize(api_key, **kwargs) #:notnew:
      @api_key = api_key
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
      OWMO::API.get(uri)

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

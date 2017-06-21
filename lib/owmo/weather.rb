require 'net/http'
require 'set'
require 'uri'

require 'core_extensions/net/http_response/weather_response'
require 'owmo/weather/attributes'
require 'owmo/weather/exceptions'


=begin rdoc
Include some weather response info into Net::HTTPResponse
=end
Net::HTTPResponse.include CoreExtensions::Net::HTTPResponse::WeatherResponse


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
    include WeatherAttributes
    include WeatherExceptions

=begin rdoc
OpenWeatherMap.Org weather API key
=end
    attr_reader :api_key

=begin rdoc
Either yeild the class, or instanciate it.
==== Attributes
* +api_key+ - OpenWEatherMap.Org's weather API key
* +**kwargs+ - Any additional paramters
=end
    def initialize(api_key, **kwargs)
      @api_key = api_key
      yield self if block_given?
    end

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
    def get(path=nil, query={})
      # Format Geocode info
      query = alias_geocodes query

      # Add the api key
      query[:APPID] = @api_key

      # Create the uri
      raise InvalidPathSpecified.new(path) if Paths[path].nil?
      uri = URI "#{OWMO::URL}/#{Paths[path]}?#{URI.encode_www_form(query).gsub('%2C', ',')}"

      # Get the weather data
      request = Net::HTTP::Get.new(uri)
      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end # response

      # Check the response
      raise WeatherResponseError.new(response) if response.has_error?

      response.weather
    end

=begin rdoc
Ensure appropriate query options are applied to the final URI
=end
  private
  def alias_geocodes(**query)

    # May never be called since query is requiredcity_name
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
          end
        else
          query[geocodes[:query]] = query.delete(intersect[0]) unless geocodes[:query] == intersect[0]
        end

        return query
      end
    end

    raise MissingGeocodes
  end

  end
end

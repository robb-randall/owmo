require 'logger'
require 'net/http'

require 'core_extensions/net/http_response/weather_response'


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

=begin rdoc
Weather response error to handle errors received from OpenWeatherMap.orgs API
=end
    class WeatherResponseError < StandardError
      def initialize(response)
        @response = response
        super("ERROR #{@response.weather_code}: #{@response.weather_message}")
      end
    end

=begin rdoc
OpenWeatherMap.Org weather API key
=end
    attr_reader :api_key

=begin rdoc
Access current or forecasted conditions by (required):
=end
    Paths = {
      current: 'weather', # Current weather data
      group: 'group', # Current weather w/multiple IDs
      box: 'box/city', # Current weather w/in a rectangle box
      circle: 'find', # Current weather w/in a circle
      forecast5: 'forecast', # 5 day / 3 hour forecast
      forecast16: 'forecast/daily' # 16 day / daily forecast
    }

=begin rdoc
Geocode aliases
=end
    Geocode_Aliases = {
      city_name: :q,
      city_id: :id,
      zip_code: :zip,
      latitude: :lat,
      longitude: :lon,
      box: :bbox
    }

=begin rdoc
Either yeild the class, or instanciate it.
==== Attributes
* +api_key+ - OpenWEatherMap.Org's weather API key
* +**kwargs+ - Any additional paramters
=end
    def initialize(api_key, **kwargs)
      @api_key = api_key

      if block_given?
        yield self
      end
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
    def get(path, **query)

      # Format Geocode info
      query = alias_geocodes(query)

      # Add the api key
      query[:APPID] = api_key

      # Create the uri
      uri = format_uri(OWMO::URL, Paths[path], query)

      # Get the weather data
      GET(uri)
    end

    private

=begin rdoc
Retruns the geocode keys from specified query.
=end
      def query_geocode_keys(**query)
        query.keys & Geocode_Aliases.keys
      end

=begin rdoc
Aliases some geocode parameters to the correct ones, for example :city_name is
easier to read than :q
=end
      def alias_geocodes(**query)
        query_geocode_keys(query).each do |key|
          query[Geocode_Aliases[key]] = query.delete(key)
        end
        query
      end

=begin rdoc
Formats the url with the given url, path, and query
=end
      def format_uri(url, path, query)
        URI "#{url}/#{path}?#{URI.encode_www_form(query).gsub('%2C', ',')}"
      end

=begin rdoc
Sends the GET request to OpenWeatherMap.org
=end
      def GET(uri)
        response = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(Net::HTTP::Get.new(uri))
        end

        # Check the response
        raise WeatherResponseError.new(response) if response.has_error?

        response.weather
      end

  end
end

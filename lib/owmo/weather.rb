# frozen_string_literal: true

require 'core_extensions/net/http_response/weather_response'

require 'json'
require 'logger'
require 'net/http'

Net::HTTPResponse.include CoreExtensions::Net::HTTPResponse::WeatherResponse

module OWMO
  # rdoc
  # A weather class for retrieving current and forecasted weather conditions.
  # ==== Attributes
  # * +api_key+ - {OpenWeatherMap.org API key}[http://openweathermap.org/appid]
  # ==== Examples
  #   api_key = "<My API Key>"
  #   weather = OWMO::Weather.new api_key: api_key
  #   puts weather.get :current, city_name: "London,uk"
  class Weather
    # rdoc
    # Weather response error to handle errors received from OpenWeatherMap.orgs API
    class WeatherResponseError < StandardError
      def initialize(response)
        super("ERROR #{response.weather_code}: #{response.message}")
      end
    end

    # rdoc
    # OpenWeatherMap.Org weather API key
    attr_reader :api_key

    # rdoc
    # Access current or forecasted conditions by (required):
    PATHS = {
      current: 'weather', # Current weather data
      group: 'group', # Current weather w/multiple IDs
      box: 'box/city', # Current weather w/in a rectangle box
      circle: 'find', # Current weather w/in a circle
      forecast5: 'forecast', # 5 day / 3 hour forecast
      forecast16: 'forecast/daily' # 16 day / daily forecast
    }.freeze

    # rdoc
    # Geocode aliases
    GEOCODE_ALIASES = {
      city_name: :q,
      city_id: :id,
      zip_code: :zip,
      latitude: :lat,
      longitude: :lon,
      box: :bbox
    }.freeze

    # rdoc
    # Either yeild the class, or instanciate it.
    # ==== Attributes
    # * +api_key+ - OpenWEatherMap.Org's weather API key
    # * +**kwargs+ - Any additional paramters
    def initialize(api_key, **_kwargs)
      @api_key = api_key

      return unless block_given?

      yield self
    end

    # rdoc
    # A weather class for retrieving current and forecasted weather conditions.
    # ==== Attributes
    # * +path+ - OWMO::Wether.Path parameter
    # * +query+ - Hash of query options (Geocode, response format, units, etc.)
    # ==== Examples
    #   api_key = "<My API Key>"
    #   weather = OWMO::Weather.new api_key: api_key
    #   puts weather.get :current, city_name: "London,uk"

    def get(path, **query)
      # Format Geocode info
      query = alias_geocodes(**query)

      # Add the api key
      query[:APPID] = api_key

      # Create the uri
      uri = format_uri(OWMO::URL, PATHS[path], query)

      # Get the weather data
      response = http_get(uri)

      raise(WeatherResponseError, response) if response.error?

      response.weather
    end

    private

    # rdoc
    # Retruns the geocode keys from specified query.
    def query_geocode_keys(**query)
      query.keys & GEOCODE_ALIASES.keys
    end

    # rdoc
    # Aliases some geocode parameters to the correct ones, for example :city_name is
    # easier to read than :q
    def alias_geocodes(**query)
      query_geocode_keys(**query).each do |key|
        query[GEOCODE_ALIASES[key]] = query.delete(key)
      end
      query
    end

    # rdoc
    # Formats the url with the given url, path, and query
    def format_uri(url, path, query)
      URI "#{url}/#{path}?#{URI.encode_www_form(query).gsub('%2C', ',')}"
    end

    # rdoc
    # Sends the GET request to OpenWeatherMap.org
    # :nocov:
    def http_get(uri)
      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(Net::HTTP::Get.new(uri))
      end

      response
    end
  end
  # :nocov:
end

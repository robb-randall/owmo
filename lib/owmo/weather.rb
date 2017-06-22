require 'net/http'

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
      @debug = kwargs[:debug] || FALSE
      log "Debug= #{@debug}"

      @api_key = api_key
      log "Api Key= #{@api_key}"

      log "Args= #{kwargs}"

      if block_given?
        log "Yielding"
        yield self
        log "Yield complete."
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
      query[:APPID] = @api_key

      # Create the uri
      uri = format_uri(OWMO::URL, Paths[path], query)

      # Get the weather data
      send_request(uri).weather

    end

=begin rdoc
Aliases some geocode parameters to the correct ones, for example :city_name is
easier to read than :q
=end
    private
    def alias_geocodes(**query)
      log "Query before= #{query}"
      intersect = query.keys & Aliases.keys
      intersect.each { |key| query[Aliases[key]] = query.delete(key) }
      log "Query after= #{query}"
      query
    end

=begin rdoc
Formats the url with the given url, path, and query
=end
    private
    def format_uri(url, path, query)
      uri = URI "#{url}/#{path}?#{URI.encode_www_form(query).gsub('%2C', ',')}"
      log "URI= #{uri}"
      uri
    end

=begin rdoc
Sends the GET request to OpenWeatherMap.org
=end
    private
    def send_request(uri)
      log "Starting GET request"
      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(Net::HTTP::Get.new(uri))
      end
      log "Request returned= #{response.weather_code}: #{response.weather_message}".gsub(/: $/, '')

      # Check the response
      raise WeatherResponseError.new(response) if response.has_error?
      response
    end

=begin rdoc
Simple log method for debugging purposes
=end
    private
    def log(msg)
      puts "#{DateTime.now} :~> #{msg}" if @debug
    end

  end
end

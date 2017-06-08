require 'ext/net'
require 'ext/string'
require 'set'


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
{OpenWeatherMap.org API key}[http://openweathermap.org/appid]
=end
    attr_reader :api_key

    def initialize(**kwargs) #:notnew:
      raise "Missing required api_key" if kwargs[:api_key].nil?
      @api_key = kwargs[:api_key]
    end # initialize

=begin rdoc
A weather class for retrieving current and forecasted weather conditions.
==== Attributes
* +path+ - OWMO::PATH parameter
* +query+ - Hash of query options (Geocode, response format, units, etc.)
==== Examples
  api_key = "<My API Key>"
  weather = OWMO::Weather.new api_key: api_key
  puts weather.get :current, city_name: "London,uk"
=end
    public
    def get(path, **query)
      # Format Geocode info
      query = parse_geocode query

      # Add the api key
      query[:APPID] = @api_key if query[:APPID].nil?

      # Create the uri
      raise "Invalid path: #{path}" if OWMO::PATHS[path].nil?
      uri = "#{OWMO::URL}/#{OWMO::PATHS[path]}".to_uri query

      # Get the weather data
      body = Net::get_body uri

      # Check the response for errors
      if body.is_json?
        json = JSON::parse(body)
        raise "ERROR #{json['cod']} - #{json['message']}" if json['cod'].to_i != 200
      end

      body
    end # get

=begin rdoc
Ensure appropriate query options are applied to the final URI
=end
    private
    def parse_geocode(**query)
      has_geocode = FALSE
      OWMO::GEOCODE.each do |q, options|
        options.each do |option|
          unless query[option].nil?
            query[q] = query.delete(option)
            has_geocode = TRUE
          end # unless
        end # option
      end # GEOCODE
      raise "Missing geocode from query: #{query}" unless has_geocode
      query
    end # parase_geocode

  end # Weather
end # OWMO

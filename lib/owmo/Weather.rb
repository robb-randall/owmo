require 'ext/Net'
require 'ext/String'
require 'set'

module OWMO
  class Weather

    attr_reader :url, :api_key

    def initialize(**kwargs)
      raise "Missing required api_key" if kwargs[:api_key].nil?
      @url = kwargs[:url] || OWMO::URL
      @api_key = kwargs[:api_key]
    end # initialize

    public
    def get(path, **query)
      # Format Geocode info
      query = parse_geocode query

      # Add the api key
      query[:APPID] = @api_key if query[:APPID].nil?

      # Create the uri
      raise "Invalid path: #{path}" if OWMO::PATHS[path].nil?
      uri = "#{@url}/#{OWMO::PATHS[path]}".to_uri query

      # Get the weather data
      body = Net::get_body uri

      # Check the response for errors
      if body.is_json?
        json = JSON::parse(body)
        raise "ERROR #{json['cod']} - #{json['message']}" if json['cod'].to_i != 200
      end

      body
    end # get

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

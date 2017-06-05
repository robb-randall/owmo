require 'net/http'

module OWMO
  class Weather

    attr_reader :url, :api_key

    def initialize(**kwargs)
      raise "Missing required api_key" if kwargs[:api_key].nil?
      @url = kwargs[:url] || OWMO::URL
      @api_key = kwargs[:api_key]
    end # initialize

    public
    def get(path, **params)
      # Parse the path
      path = parse_path(path)

      # Parse the params
      params = parse_params(params)

      # Format the URI
      uri = build_uri(path, params)

      # Get the weather data
      get_weather(uri)
    end # get

    private
    def parse_path(path)
      case path
      # Current weather data
      when :current then 'weather'

      # 5 day / 3 hour forecast
      when :forecast then 'forecast'

      # 16 day / daily forecast
      when :extended then 'forecast/daily'

      # Raise an error
      else raise "Unknown path: '#{path}'"

      end # case
    end # path

    private
    def parse_params(**params)
      case
      # Search by city name
      when params.key?(:city_name) then
        params[:q] = params.delete :city_name

      # Search by city ID
      when params.key?(:city_id) then
        params[:id] = params.delete :city_id

      # Search by Zip
      when params.key?(:zip) then

      # Search by geo location
      when params.key?(:lat) && params.key?(:lon) then

      # Nothing is specified, raise an error
      else raise "Missing location parameter: #{params}"
      end # case

      params
    end # parse_params

    private
    def build_uri(path, **params)
      URI "#{@url}/#{path}?#{format_parameters(params)}"
    end # format_uri

    private
    def format_parameters(**params)
      params[:APPID] = @api_key if params[:APPID].nil?
      params.map {|k,v| "#{k}=#{v}"}.join('&')
    end # format_params

    private
    def get_weather(uri)
      Net::HTTP.start(uri.host, uri.port) do |http|
        req = Net::HTTP::Get.new uri
        resp = http.request req

        # Error if the request was unsuccessful
        raise "ERROR #{resp.code}: #{res.message} (#{res.class.name})" unless Net::HTTPSuccess

        resp.body
      end # http
    end # get_weather

  end # Weather
end # OWMO

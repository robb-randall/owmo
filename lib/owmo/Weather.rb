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

      # Add the api key
      params[:APPID] = @api_key if params[:APPID].nil?

      # Create the uri
      raise "Invalid path: #{path}" if OWMO::PATHS[path].nil?
      uri = "#{@url}/#{OWMO::PATHS[path]}".to_uri params

      # Get the weather data
      body = Net::get_body uri

      # Check the response for errors
      if body.is_json?
        json = JSON::parse(body)
        raise "ERROR #{json['cod']} - #{json['message']}" if json['cod'].to_i != 200
      end

      body
    end # get

  end # Weather
end # OWMO

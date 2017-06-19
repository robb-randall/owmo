require 'core_extensions/net/http_response/weather_response'
require 'owmo/api/exceptions'

require 'net/http'
require 'uri'


=begin rdoc
Include some weather response info into Net::HTTPResponse
=end
Net::HTTPResponse.include CoreExtensions::Net::HTTPResponse::WeatherResponse

module OWMO

=begin rdoc
Net module Mixins
=end
  module API
    include ApiExceptions

=begin rdoc
Sends the GET request to OpenWeatherMap.org, and returns the response
=end
    def self.get(uri)

      raise "Invalid URI:  Expected URI, got #{uri.class}" unless uri.is_a? URI

      # Send the request
      request = Net::HTTP::Get.new(uri)

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end # response

      # Check the response
      raise OWMO::API::WeatherResponseError.new(response) if response.has_error?

      return response.weather

    end # get
  end # Net

end # OWMO

# frozen_string_literal: true

require 'json'

module OWMO
  # Weather response class
  class WeatherResponse
    attr_reader :weather, :code

    def initialize(http_response)
      # JSON
      @weather = JSON.parse(http_response.body)
      @code = weather['cod'].to_i
    rescue JSON::ParserError, TypeError
      # Assume XML or HTML
      @weather = http_response.body
      @code = weather.length > 10 ? 200 : 500
    end

    def error?
      code != 200
    end
  end
end

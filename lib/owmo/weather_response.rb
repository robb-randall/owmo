# frozen_string_literal: true

require 'json'

module OWMO

    class WeatherResponse

        attr_reader :weather, :code

        def initialize http_response
            begin
                # JSON
                @weather = JSON.parse(http_response.body)
                @code = self.weather["cod"].to_i
            rescue JSON::ParserError, TypeError
                # Assume XML or HTML
                @weather = http_response.body
                @code = 200
            end
        end

        def error?
            self.code != 200
        end

    end

end
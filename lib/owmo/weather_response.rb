# frozen_string_literal: true


module OWMO

    class WeatherResponse

        attr_reader :weather, :code

        def initialize http_response
            @weather = http_response.body
            @code = self.weather["cod"]
        end

        def error?
            self.code != 200
        end

    end

end
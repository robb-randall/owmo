# frozen_string_literal: true

require 'owmo/version'
require 'owmo/weather'

# rdoc
# OMWO = OpenWeatherMap.org client for current and forecasted weather conditions.
module OWMO
  # rdoc
  # Openweathermap.org URL
  URL = 'http://api.openweathermap.org/data/2.5'

  # rdoc
  # Yield a weather object for querying weather data
  # ==== Attributes
  # * +api_key:+ - {OpenWeatherMap.org API key}[http://openweathermap.org/appid]
  # ==== Examples
  # * Single request:
  #   api_key = ''
  #   OWMO::weather(api_key).get :current, city_name: "London,UK"
  # * Muliple requests:
  #   api_key = ''
  #   OWMO::weather(api_key) do |weather|
  #     puts weather.get :current, city_name: "London,UK"
  #     puts weather.get :forecast5, city_name: "London,UK"
  #     puts weather.get :forecast16, city_name: "London,UK"
  #   end

  def self.weather(api_key, **kwargs)
    OWMO::Weather.new(api_key, **kwargs) do |weather|
      if block_given?
        yield weather
      else
        weather
      end
    end
  end
end

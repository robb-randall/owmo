require "owmo/version"
require "owmo/weather"


=begin rdoc
OMWO = OpenWeatherMap.org client for current and forecasted weather conditions.
=end
module OWMO

=begin rdoc
Openweathermap.org URL
=end
  URL = 'http://api.openweathermap.org/data/2.5'

=begin rdoc
Yield a weather object for querying weather data
==== Attributes
* +api_key:+ - {OpenWeatherMap.org API key}[http://openweathermap.org/appid]
==== Examples
* Single request:
  api_key = ''
  OWMO::weather(api_key).get :current, city_name: "London,UK"
* Muliple requests:
  api_key = ''
  OWMO::weather(api_key) do |weather|
    puts weather.get :current, city_name: "London,UK"
    puts weather.get :forecast5, city_name: "London,UK"
    puts weather.get :forecast16, city_name: "London,UK"
  end
=end
  public
  def self.weather(api_key, **params)
    Weather.new(api_key, params) do |weather|
      if block_given?
        yield weather
      else
        weather
      end
    end
  end

end

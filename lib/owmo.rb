require "owmo/api"
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
  api_key = "<My API Key>"
  OWMO::weather api_key do |weather|
    puts weather.get :current, city_name: "London,uk"
  end
=end
  public
  def self.weather(api_key, **params)
    weather = Weather.new(api_key, params)

    if block_given?
      yield weather
    else
      return weather
    end
  end # weather

end # OWMO

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
Access current or forecasted conditions by (required):
* +:current+ - {Current weather data}[http://openweathermap.org/current]
* +:forecast+ - {5 day / 3 hour forecast}[http://openweathermap.org/forecast5]
* +:extended+ - {16 day / daily forecast}[http://openweathermap.org/forecast16]
=end
  PATHS = {
    current: 'weather', # Current weather data
    forecast: 'forecast', # 5 day / 3 hour forecast
    extended: 'forecast/daily' # 16 day / daily forecast
  }

=begin rdoc
{Geocode options (required):}[http://openweathermap.org/current#one]
* +q:+ or +city_name:+ - By city name
* +id:+ or +city_id:+ - By city ID
* +zip:+ or +zip_code:+ - By zip code
* +lat:+, +lon:+ or +latitude:+, +longitude:+ - By geographic coordinates
=end
  GEOCODES = {
    "City Name" => {
      query: :q,
      options: [:q, :city_name]
    },
    "City ID" => {
      query: :id,
      options: [:id, :city_id]
    },
    "Zip Code" => {
      query: :zip,
      options: [:zip, :zip_code]
    },
    "Coordinance" => {
      query: [:lat, :lon],
      options: [[:lat, :lon], [:lattitude, :longitude]]
    }
  }

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
  def self.weather(**params)
    w = Weather.new params
    yield w
  end # weather

end # OWMO

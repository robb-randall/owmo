require 'ext/Net'
require 'ext/String'
require "owmo/version"
require "owmo/Weather"


module OWMO
  URL = 'http://api.openweathermap.org/data/2.5'

  PATHS = {
    current: 'weather', # Current weather data
    forecast: 'forecast', # 5 day / 3 hour forecast
    extended: 'forecast/daily' # 16 day / daily forecast
  }

  LOCATIONS = [
    "q", # City Name
    "id", # City ID
    "zip", # Zip
    ["lat", "lon"] # Coord
  ]

  FORMATS = {
    json: {mode: "json"},
    xml: {mode: "xml"},
    html:  {mode: "html"}
  }

  UNITS = {
    kelvin: {},
    imperial: {units: 'imperial'},
    metric: {units: 'metric'}
  }

  public
  def self.weather(**params)
    w = Weather.new params
    yield w
  end # weather

end # OWMO

module WeatherAttributes

=begin rdoc
Access current or forecasted conditions by (required):
=end
  Paths = {
    current: 'weather', # Current weather data
    group: 'group', # Current weather w/multiple IDs
    box: 'box/city', # Current weather w/in a rectangle box
    circle: 'find', # Current weather w/in a circle
    forecast5: 'forecast', # 5 day / 3 hour forecast
    forecast16: 'forecast/daily' # 16 day / daily forecast
  }

=begin rdoc
{Geocode options (required):}[http://openweathermap.org/current#one]
=end
  Geocodes = {
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
    },
    "Cities Within a Rectangle Zone" => {
      query: :bbox,
      options: [:bbox]
    },
    "Cities Within a Circle" => {
      query: [:lat, :lon, :cnt],
      options: [[:lat, :lon, :cnt],[:lattitude, :longitude, :cnt]]
    }
  }

end

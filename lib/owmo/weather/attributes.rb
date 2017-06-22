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
Geocode aliases
=end
  Aliases = {
    city_name: :q,
    city_id: :id,
    zip_code: :zip,
    latitude: :lat,
    longitude: :lon
  }

end

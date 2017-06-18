require 'owmo'

api_key = ""

weather = OWMO::Weather.new api_key

# Kelvin
puts weather.get :current, city_name: "London,UK"

# Imperial
puts weather.get :current, city_name: "London,UK", units: :imperial

# Metric
puts weather.get :current, city_name: "London,UK", units: :metric

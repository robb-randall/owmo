# frozen_string_literal: true

require 'owmo'

api_key = ''

weather = OWMO::Weather.new api_key

# Geocode by City ID
puts weather.get :current, city_id: 5_328_041
puts weather.get :current, id: 5_328_041

# Geocode by City Name
puts weather.get :current, city_name: 'Beverly Hills'
puts weather.get :current, q: 'Beverly Hills'

# Geocode by Zip Code
puts weather.get :current, zip: 90_210
puts weather.get :current, zip_code: 90_210

# Geocode by Coordinance
puts weather.get :current, lon: -118.41, lat: 34.09

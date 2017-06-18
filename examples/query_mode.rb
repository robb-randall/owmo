require 'owmo'

api_key = ""

weather = OWMO::Weather.new api_key

# Response in JSON format
puts weather.get :current, city_name: "London,UK"
puts weather.get :current, city_name: "London,UK", mode: :json

# Response in XML format
puts weather.get :current, city_name: "London,UK", mode: :xml

# Response in HTML format
puts weather.get :current, city_name: "London,UK", mode: :html

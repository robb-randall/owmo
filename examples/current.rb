require 'owmo'

=begin rdoc
An example on how to get current conditions and use the different parameters.
=end
api_key = ""

weather = OWMO::Weather.new api_key

# http://openweathermap.org/current#data
current = weather.get :current, city_name: "London,UK"

puts current

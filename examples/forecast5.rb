require 'owmo'


=begin rdoc
An example on how to get the extended forcast and use the different parameters.
=end
api_key = ""

weather = OWMO::Weather.new api_key

# http://openweathermap.org/forecast5
forecast5 = weather.get :forecast5, city_name: "London,UK"

puts forecast5

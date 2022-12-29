# frozen_string_literal: true

require 'owmo'

# rdoc
# An example on how to get the weather forcast and use the different parameters.
api_key = ''

weather = OWMO::Weather.new api_key

# http://openweathermap.org/forecast16
forecast16 = weather.get :forecast16, city_name: 'London,UK'

puts forecast16

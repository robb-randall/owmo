require 'owmo'

api_key = ""

OWMO::weather(api_key) do |weather|
  puts weather.get :circle, lat: 55.5, lon: 37.5, cnt: 10
end

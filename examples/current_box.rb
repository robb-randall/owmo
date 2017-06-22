require 'owmo'

api_key = ""

OWMO::weather(api_key) do |weather|
  puts weather.get :box, bbox: [12, 32, 15, 37, 10].join(',')
end

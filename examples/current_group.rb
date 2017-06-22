require 'owmo'

api_key = ""

OWMO::weather(api_key) do |weather|
  puts weather.get :group, id: [4850751,4887398,2643743,4164138,5368361].join(',')
end

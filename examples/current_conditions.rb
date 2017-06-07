require 'owmo'

api_key = ""

OWMO::weather api_key: api_key do |weather|

  # http://openweathermap.org/current#data
  query = {
    city_name: "London,uk", # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  current_condition = weather.get :current, query

  puts current_condition
end

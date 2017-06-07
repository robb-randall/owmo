require 'owmo'

api_key = ""

OWMO::weather api_key: api_key do |weather|

  # http://openweathermap.org/forecast5
  query = {
    zip: "90210", # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  forecast = weather.get :forecast, query

  puts forecast
end

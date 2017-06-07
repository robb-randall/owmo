require 'owmo'

api_key = ""

OWMO::weather api_key: api_key do |weather|

  # http://openweathermap.org/forecast16
  query = {
    lat: "40.7128", lon: "74.0059",  # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  extended = weather.get :extended, query

  puts extended
end

# frozen_string_literal: true

require 'owmo'

api_key = ''

weather = OWMO::Weather.new api_key

query = {
  city_name: 'London,UK', # Geolocation, required
  mode: 'json', # Return data [json (defaul), xml, html]
  units: 'imperial', # [imperial, metric, or blank (Default, Kelvin)]
  lang: 'fr' # Language support
}

current = weather.get :current, query

puts current

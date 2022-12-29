# frozen_string_literal: true

require 'owmo'

api_key = ''

OWMO.weather(api_key) do |weather|
  puts weather.get :group, id: [4_850_751, 4_887_398, 2_643_743, 4_164_138, 5_368_361].join(',')
end

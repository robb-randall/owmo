# frozen_string_literal: true

require 'owmo'
require 'sinatra' # Need to install, not included in gemspec
require 'uri'

get '/current/:name' do
  api_key = '<API Key>'
  weather = OWMO::Weather.new api_key
  weather.get :current, city_name: params[:name], mode: :html
end

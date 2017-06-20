# OWMO - OpenWeatherMap.Org Client API

Ruby client for openweathermap.org client API.  Currently only for current and forecast information.

[![Gem Version](https://badge.fury.io/rb/owmo.svg)](https://badge.fury.io/rb/owmo)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'owmo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install owmo

## Usage

You'll need and API key from [OpenWeatherMap.org](http://openweathermap.org/appid).

Complete examples can be found under owmo/examples.

----
### Quick Start

```ruby
require 'owmo'
api_key = "<api key here>"
weather = OWMO::weather api_key
puts weather.get :current, city_name: "London,UK"
```

```ruby
require 'owmo'
api_key = "<api key here>"
OWMO::weather(api_key) { |weather| puts weather.get :current, city_name: "London,UK" }
```
----
### Weather Information
#### [Current weather data](http://openweathermap.org/current)
```ruby
weather.get :current, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/current.rb)

#### [5 day weather forecast](http://openweathermap.org/forecast5)
```ruby
weather.get :forecast5, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/forecast5.rb)

#### [16 day weather forecast](http://openweathermap.org/forecast16)
```ruby
weather.get :forecast16, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/forecast16.rb)

----
### Query parameters

#### Geocode (required)
```ruby
# Geocode by City ID
weather.get :current, city_id: 5328041
weather.get :current, id: 5328041

# Geocode by City Name
weather.get :current, city_name: "Beverly Hills"
weather.get :current, q: "Beverly Hills"

# Geocode by Zip Code
weather.get :current, zip: 90210
weather.get :current, zip_code: 90210

# Geocode by Coordinance
weather.get :current, lon: -118.41, lat: 34.09
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_geocode.rb)

#### Mode
```ruby
# Response in JSON format (default)
weather.get :current, city_name: "London,UK"
weather.get :current, city_name: "London,UK", mode: :json

# Response in XML format
weather.get :current, city_name: "London,UK", mode: :xml

# Response in HTML format
weather.get :current, city_name: "London,UK", mode: :html
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_mode.rb)

#### Units
```ruby
# Kelvin (default)
weather.get :current, city_name: "London,UK"

# Imperial
weather.get :current, city_name: "London,UK", units: :imperial

# Metric
weather.get :current, city_name: "London,UK", units: :metric
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_units.rb)

#### All
```ruby
query = {
  city_name: "London,UK",
  mode: 'json',
  units: 'imperial',
  lang: 'fr'
}

weather.get :current, query
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_all.rb)

----
### Working example using Sinatra

```ruby
require 'owmo'
require 'sinatra' # Need to install, not included in gemspec
require 'uri'

get '/current/:name' do
    api_key = '<API Key>'
    weather = OWMO::Weather.new api_key
    weather.get :current, city_name: params[:name], mode: :html
end
```

Then navigate to: http://localhost:4567/current/London,UK

[Full example](https://github.com/robb-randall/owmo/blob/master/examples/sinatra_example.rb)

----
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/robb-randall/owmo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

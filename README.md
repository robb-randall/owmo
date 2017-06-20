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
puts OWMO::weather(api_key).get :current, city_name: "London,UK"
```

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
OWMO::weather(api_key).get :current, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/current.rb)

### [Current weather data for multiple cities](http://openweathermap.org/current#severalid)
```ruby
OWMO::weather(api_key).get :group, city_id: [4850751,4887398,2643743,4164138,5368361].join(",")
```

#### [5 day weather forecast](http://openweathermap.org/forecast5)
```ruby
OWMO::weather(api_key).get :forecast5, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/forecast5.rb)

#### [16 day weather forecast](http://openweathermap.org/forecast16)
```ruby
OWMO::weather(api_key).get :forecast16, city_name: "London,UK"
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/forecast16.rb)

----
### Query parameters

#### Geocode (required)
```ruby
# Geocode by City ID
OWMO::weather(api_key).get :current, city_id: 5328041
OWMO::weather(api_key).get :current, id: 5328041

# Geocode by City Name
OWMO::weather(api_key).get :current, city_name: "Beverly Hills"
OWMO::weather(api_key).get :current, q: "Beverly Hills"

# Geocode by Zip Code
OWMO::weather(api_key).get :current, zip: 90210
OWMO::weather(api_key).get :current, zip_code: 90210

# Geocode by Coordinance
OWMO::weather(api_key).get :current, lon: -118.41, lat: 34.09
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_geocode.rb)

#### Mode
```ruby
# Response in JSON format (default)
OWMO::weather(api_key).get :current, city_name: "London,UK"
OWMO::weather(api_key).get :current, city_name: "London,UK", mode: :json

# Response in XML format
OWMO::weather(api_key).get :current, city_name: "London,UK", mode: :xml

# Response in HTML format
OWMO::weather(api_key).get :current, city_name: "London,UK", mode: :html
```
[Full example](https://github.com/robb-randall/owmo/blob/master/examples/query_mode.rb)

#### Units
```ruby
# Kelvin (default)
OWMO::weather(api_key).get :current, city_name: "London,UK"

# Imperial
OWMO::weather(api_key).get :current, city_name: "London,UK", units: :imperial

# Metric
OWMO::weather(api_key).get :current, city_name: "London,UK", units: :metric
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

OWMO::weather(api_key).get :current, query
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

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

You'll need and API key from OpenWeatherMap.org (http://openweathermap.org/appid).

Compelete examples can be found under owmo/examples.

----
### Quick Start

```ruby
require 'owmo'
api_key = "<api key here>"
weather = OWMO::Weather.new api_key: api_key
puts weather.get :current, zip: 52402
```

```ruby
require 'owmo'
api_key = "<api key here>"
OWMO::weather api_key: api_key do |weather|
    puts weather.get :forecast, zip: 52402
end
```
----

### Current weather data (http://openweathermap.org/current)
```ruby
  params = {
    city_name: "London,uk", # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  puts weather.get :current, params

```
### 5 day weather forecast (http://openweathermap.org/forecast5)
```ruby
  params = {
    zip: "90210", # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  puts weather.get :forecast, params
```

### 16 day weather forecast (http://openweathermap.org/forecast16)
```ruby
  params = {
    lat: "40.7128", lon: "74.0059",  # [city_name, city_id, zip, lat/lon]
    mode: 'json', # [json, xml, html] Not required, but an option
    units: 'imperial', # [imperial, metric] Not required, but an option
    lang: 'en_US' # Not required, but an option
  }

  puts weather.get :extended, params
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/owmo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


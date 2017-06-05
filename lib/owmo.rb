require "owmo/version"
require "owmo/Weather"


module OWMO
  URL = 'http://api.openweathermap.org/data/2.5'

  public
  def self.weather(**params)
    w = Weather.new params
    yield w
  end # weather

end

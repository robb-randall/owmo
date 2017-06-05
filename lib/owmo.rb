require "owmo/version"
require "owmo/Weather"


module OWMO
  URL = ''

  public
  def self.weather(params)
    w = Weather.new params
    yield w
  end # weather

  public
  def self.pretty_json(json)
    begin
      json = JSON.parse(json) unless json.is_a? Hash
      JSON.pretty_generate(json)
    rescue
      json
    end
  end # pretty_json


end


module WeatherExceptions

=begin rdoc
Invalid path specified
=end
  class InvalidPathSpecified < StandardError
    def initialize(path=nil)
      @path = path
      super("Invalid path specified: Got: '#{@path}', expected one of: #{Paths.keys}")
    end # initialize
  end # NoGeocodeSpecified

=begin rdoc
Missing Geocode from query
=end
  class MissingGeocodes < StandardError
  end # MissingGeocodes

end # WeatherExceptions

require 'net/http'


=begin rdoc
Net module Mixins
=end
module Net

=begin rdoc
Mixin to the Net module to encapsulate the GET request that returns the response body
=end
  def self.get_body(uri)
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request

      return response.body
    end # http
  end # get_weather

end # Net

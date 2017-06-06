require 'net/http'


module Net

  def self.get_body(uri)
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request

      return response.body
    end # http
  end # get_weather

end # Net

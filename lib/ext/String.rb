require 'json'
require 'uri'


class String

	public
	def to_uri(params=nil)
		case params
		when nil then
			URI self
		when String
			URI "#{self}?#{params}"
		when Array, Hash
			URI "#{self}?#{URI.encode_www_form(params)}"
		else
			raise "Cannot convert to URI"
		end # case
	end # String.to_uri

	def is_json?
		begin
			JSON.parse(self)
			true
		rescue
			false
		end
	end # is_json?

end # String

require 'json'
require 'uri'


class String

	public
	def to_uri(query=nil)
		case query
		when nil then
			URI self
		when String
			URI "#{self}?#{query}"
		when Array, Hash
			URI "#{self}?#{URI.encode_www_form(query)}"
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

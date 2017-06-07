require 'json'
require 'uri'

=begin rdoc
String class Mixins
=end
class String

=begin rdoc
String mixin to converts a string to URI
=end
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

=begin rdoc
String mixin for determining if a string is in JSON format or not
=end
	def is_json?
		begin
			JSON.parse(self)
			true
		rescue
			false
		end
	end # is_json?

end # String

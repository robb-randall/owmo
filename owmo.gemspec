# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'owmo/version'

Gem::Specification.new do |spec|
  spec.name          = "owmo"
  spec.version       = OWMO::VERSION
  spec.authors       = ["Robb"]
  spec.email         = ["robb.randall@gmail.com"]

  spec.summary       = %q{OpenWeatherMap.org client for current and forecasted weather conditions.}
  spec.description   = %q{OpenWeatherMap.org client for current and forecasted weather conditions.}
  spec.homepage      = "https://github.com/robb-randall/owmo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.x"
  spec.add_development_dependency "rake", "~> 13.x"
  spec.add_development_dependency "rspec", "~> 3.x"
end

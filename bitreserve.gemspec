# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitreserve/version'

Gem::Specification.new do |spec|
  spec.name          = 'bitreserve'
  spec.version       = Bitreserve::VERSION
  spec.authors       = ['Group Buddies']
  spec.email         = ['zamith@groupbuddies.com', 'mpalhas@groupbuddies.com']
  spec.summary       = %q{A wrapper for the bitreserve API}
  spec.homepage      = 'https://github.com/groupbuddies/bitreserve'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '>= 0.13.3'
  spec.add_dependency 'virtus', '>= 1.0.4'
  spec.add_dependency 'dotenv'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'climate_control'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.27.1'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'webmock', '~> 1.20.4'
end

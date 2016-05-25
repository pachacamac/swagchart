# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swagchart/version'

Gem::Specification.new do |spec|
  spec.name          = 'swagchart'
  spec.version       = Swagchart::VERSION
  spec.authors       = ['pachacamac']
  spec.email         = ['pachacamac@inboxalias.com']
  spec.description   = 'Use Google Charts easily within your Rails or Sinatra project or anywhere really'
  spec.summary       = 'Small Wrapper Around Google CHARTS'
  spec.homepage      = 'https://github.com/pachacamac/swagchart'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'minitest', '~> 5.9'
  spec.add_development_dependency 'rake', '~> 11.1'
end

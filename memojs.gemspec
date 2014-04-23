# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memojs/version'

Gem::Specification.new do |spec|
  spec.name          = "memojs"
  spec.version       = Memojs::VERSION
  spec.authors       = ["Niels Buus"]
  spec.email         = ["nielsbuus@gmail.com"]
  spec.summary       = "A lightweight wrapper for the localStorage API packaged as a Rails asset"
  spec.description   = <<-DESC
  To use it, you must require memojs in your JavaScript manifest. Add this line to your application.js file:

      //= require memojs

  DESC
  spec.homepage      = "http://github.com/lokalebasen/memojs"
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'railties', ">= 3.1", "< 5.0"
  spec.add_dependency 'coffee-rails'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gurk/version'

Gem::Specification.new do |spec|
  spec.name          = "gurk"
  spec.version       = Gurk::VERSION
  spec.authors       = ["Vixon"]
  spec.email         = [""]
  spec.description   = %q{Gurk}
  spec.summary       = %q{A plain english ruby microframework that }
  spec.homepage      = "http://github.com/vixon/gurk"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"

  spec.add_dependency "gherkin"
  spec.add_dependency 'http_router', '~> 0.11.0'
  spec.add_dependency 'tilt'
  spec.add_dependency 'thor'
end

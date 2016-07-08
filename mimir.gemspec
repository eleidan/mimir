# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mimir/version'

Gem::Specification.new do |spec|
  spec.name          = "mimir"
  spec.version       = Mimir::VERSION
  spec.authors       = ["Oleg «Eleidan» Kulyk"]
  spec.email         = ["helh.saintman@gmail.com"]
  spec.summary       = %q{Introspection utility for Ruby language.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/eleidan/mimir"
  spec.license       = "GPL-3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "docopt",   "~>0.5"

  spec.add_development_dependency "bundler",  "1.6.2"
  spec.add_development_dependency "rake",     "~> 10.4"
  spec.add_development_dependency "rspec",    "~> 3.2"
  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "aruba",    "~> 0.5"
  spec.add_development_dependency "simplecov","~> 0.9"
  spec.add_development_dependency "codeclimate-test-reporter","~> 0.4"
end

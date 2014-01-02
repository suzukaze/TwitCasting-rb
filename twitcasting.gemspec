# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twitcasting/version'

Gem::Specification.new do |spec|
  spec.name          = "twitcasting"
  spec.version       = TwitCasting::VERSION
  spec.authors       = ["Jun Hiroe"]
  spec.email         = ["Jun.Hiroe@gmail.com"]
  spec.summary       = %q{twicasting API wrapper}
  spec.description   = %q{twicasting API wrapper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

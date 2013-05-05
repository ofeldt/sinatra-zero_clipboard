# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sinatra/zero_clipboard/version"

Gem::Specification.new do |spec|
  spec.name          = "sinatra-zero_clipboard"
  spec.version       = Sinatra::ZeroClipboard::VERSION
  spec.authors       = ["Oliver Feldt"]
  spec.email         = ["oliver.feldt@googlemail.com"]
  spec.description   = "Sinatra integration for ZeroClipboard" 
  spec.summary       = "Adds helpers to enable the use of the clipboard on websites" 
  spec.homepage      = "https://github.com/ofeldt/sinatra-zero_clipboard"
  spec.license       = "ISC"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",    "~> 1.3"
  spec.add_development_dependency "rack",       "~> 1.5.2"
  spec.add_development_dependency "rack-test",  "~> 0.6.2"
  spec.add_development_dependency "rspec",      "~> 2.13.0"
  spec.add_development_dependency "simplecov",  "~> 0.7.1"
  spec.add_development_dependency "slim",       "~> 1.3.8"
  spec.add_development_dependency "pry",        "~> 0.9.12.1"

  spec.add_runtime_dependency "sinatra", "~> 1.4.2"
end

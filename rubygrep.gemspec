# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubygrep/version'

Gem::Specification.new do |spec|
  spec.name          = "rubygrep"
  spec.version       = Rubygrep::VERSION
  spec.authors       = ["andrey"]
  spec.email         = ["om08uhkn@gmail.com"]
  spec.summary       = %q{Analog of unix grep utility.}
  spec.description   = %q{Globally searches regexp and prints it}
  spec.homepage      = "https://github.com/fatbeard2/rubygrep"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'rubygrep'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

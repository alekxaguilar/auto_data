# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auto_data/version'

Gem::Specification.new do |spec|
  spec.name          = "auto_data"
  spec.version       = AutoData::VERSION
  spec.authors       = ["Alejandro Aguilar"]
  spec.email         = ["alekx.aguilar@gmail.com"]

  spec.summary       = %q{Manage Test and Configuration data. }
  spec.description   = %q{Manage Test and configuration data for any automated test project.}
  spec.homepage      = "https://github.com/alekxaguilar/auto_data"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mint/helper/version'

Gem::Specification.new do |spec|
  spec.name          = "mint-helper"
  spec.version       = Mint::Helper::VERSION
  spec.authors       = ["Ben Bergstein"]
  spec.email         = ["bennyjbergstein@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "capybara-webkit"
  spec.add_dependency "selenium-webdriver"
  spec.add_dependency "capybara"
  spec.add_dependency "launchy"
  spec.add_dependency "foreman"
  spec.add_dependency "pg"
  spec.add_dependency "sequel"
  spec.add_dependency "mail"
  spec.add_dependency "premailer"
  spec.add_dependency "activesupport"
  spec.add_dependency "retriable"
end

# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epi_js/version'

Gem::Specification.new do |gem|
  gem.name          = "epi_js"
  gem.version       = EpiJs::VERSION
  gem.authors       = ["Shuo Chen", "Ryan Bibby"]
  gem.email         = ["s.chen@epigenesys.co.uk"]
  gem.description   = %q{jQuery scripts used in various projects}
  gem.summary       = %q{jQuery scripts used in various projects}
  gem.homepage      = "https://github.com/epigenesys/epi-js"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  
  gem.add_dependency 'railties', '>= 3.0'
  gem.add_dependency 'coffee-rails', '>= 3.2'
  gem.add_dependency 'sass-rails', '>= 3.2'
  gem.add_dependency 'bootstrap-sass'

  gem.add_development_dependency 'bundler', '>= 1.0'
  gem.add_development_dependency 'rails', '>= 3.0'
end

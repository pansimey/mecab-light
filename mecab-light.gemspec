# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mecab/light/version'

Gem::Specification.new do |gem|
  gem.name          = "mecab-light"
  gem.version       = MeCab::Light::VERSION
  gem.authors       = ["Hajime WAKAHARA"]
  gem.email         = ["hajime.wakahara@gmail.com"]
  gem.description   = %q{Use a sequence of results as an Enumerable object.}
  gem.summary       = %q{A Thin Wrapper for mecab-ruby}
  gem.homepage      = "https://github.com/hadzimme/mecab-light"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.required_ruby_version = '>= 1.9'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end

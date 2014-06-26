base_dir = File.dirname(__FILE__)
ext_dir = File.join(base_dir, 'ext', 'mecab')

guess_version = lambda do |ext_dir|
  version = {}

  File.open(File.join(ext_dir, 'light.c')) do |light_c|
    light_c.each_line do |line|
      case line
      when /\A#define MECAB_LIGHT_([A-Z]+)_VERSION (\d+)/
        version[$1.intern] = $2
      end
    end
  end

  [version[:MAJOR], version[:MINOR], version[:PATCH]].join('.')
end

Gem::Specification.new do |gem|
  gem.name          = "mecab-light"
  gem.version       = guess_version.call(ext_dir)
  gem.authors       = ["Hajime Wakahara"]
  gem.email         = ["hadzimme@icloud.com"]
  gem.description   = %q{Use a sequence of morphemes as an Enumerable object.}
  gem.summary       = %q{An simple interface for MeCab (UNOFFICIAL)}
  gem.homepage      = "https://github.com/hadzimme/mecab-light"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.required_ruby_version = '>= 2.0'
  gem.extensions << 'ext/mecab/extconf.rb'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'test-unit'
end

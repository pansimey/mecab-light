# MeCab::Light

[gem]: http://badge.fury.io/rb/mecab-light
[travis]: https://travis-ci.org/hadzimme/mecab-light
[coveralls]: https://coveralls.io/r/hadzimme/mecab-light?branch=master
[codeclimate]: https://codeclimate.com/github/hadzimme/mecab-light
[gemnasium]: https://gemnasium.com/hadzimme/mecab-light

Use a sequence of morphemes as an Enumerable object.

## Installation

Add this line to your application's Gemfile:

    gem 'mecab-light'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mecab-light

Install on Windows:

    $ gem install mecab-light -- --with-mecab-folder=C:/MeCab # assign yours

## Usage

```ruby
require 'mecab/light'

tagger = MeCab::Light::Tagger.new('')
string = 'この文を形態素解析してください。'
result = tagger.parse(string)
result.kind_of?(Enumerable) #=> true
result.map(&:surface)
#=> ["この", "文", "を", "形態素", "解析", "し", "て", "ください", "。"]

model = MeCab::Light::Model.new('')
tagger = MeCab::Light::Tagger.new(model)
lattice = MeCab::Light::Lattice.new(model)
lattice.sentence = 'この文を形態素解析してください。'
result = tagger.parse(lattice)
result.map(&:surface)
#=> ["この", "文", "を", "形態素", "解析", "し", "て", "ください", "。"]
```

MeCab::Light is a lightweight tool.
This gem works without the official binding.
Note that this supports less methods than those of C API for now.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

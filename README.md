# MeCab::Light

[![Gem Version](https://badge.fury.io/rb/mecab-light.png)][gem]
[![Build Status](https://travis-ci.org/hadzimme/mecab-light.png)][travis]
[![Coverage Status](https://coveralls.io/repos/hadzimme/mecab-light/badge.png?branch=master)][coveralls]
[![Code Climate](https://codeclimate.com/repos/52d6b3afe30ba0304300e862/badges/1667a80ba014a14e77f6/gpa.png)][codeclimate]
[![Dependency Status](https://gemnasium.com/hadzimme/mecab-light.png)][gemnasium]

[gem]: http://badge.fury.io/rb/mecab-light
[travis]: https://travis-ci.org/hadzimme/mecab-light
[coveralls]: https://coveralls.io/r/hadzimme/mecab-light?branch=master
[codeclimate]: https://codeclimate.com/repos/52d6b3afe30ba0304300e862/feed
[gemnasium]: https://gemnasium.com/hadzimme/mecab-light

Use a sequence of morphemes as an Enumerable object.

## Installation

Add this line to your application's Gemfile:

    gem 'mecab-light'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mecab-light

## Usage

```ruby
require 'mecab/light'

tagger = MeCab::Light::Tagger.new
string = 'この文を形態素解析してください。'
result = tagger.parse(string)
result[0].surface #=> "この"
result.kind_of?(Enumerable) #=> true
result.map(&:surface)
#=> ["この", "文", "を", "形態素", "解析", "し", "て", "ください", "。"]
```

MeCab::Light is a lightweight tool.
This gem works without the official binding.
This supports only Tagger#parse method for now.
Note that the method's feature is totally different from its original.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

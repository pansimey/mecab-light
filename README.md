# mecab-light

Use a sequence of results as an Enumerable object.

## Installation

Add this line to your application's Gemfile:

    gem 'mecab-light'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mecab-light

## Usage

```ruby
require 'mecab-light'

mecab = Mecab.new
text = 'この文を形態素解析してください。'
result = mecab.parse(text)
result[0].surface #=> "この"
result.map{|morpheme| morpheme.surface }
#=> ["この", "文", "を", "形態素", "解析", "し", "て", "ください", "。"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mecab/light/morpheme'
require 'mecab/light/result'
require 'mecab/light/tagger'

class MeCab::Light::Binding
end

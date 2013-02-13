require 'MeCab'
require 'mecab-light/version'
require 'mecab-light/result'
require 'mecab-light/morpheme'

class Mecab
  def initialize
    @tagger = MeCab::Tagger.new
  end

  def parse(text)
    Result.new(@tagger.parse(text).split(/\n/)[0..-2])
  end
end

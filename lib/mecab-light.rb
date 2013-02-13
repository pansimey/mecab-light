require 'MeCab'
require 'mecab-light/version'
require 'mecab-light/tagger'
require 'mecab-light/result'
require 'mecab-light/morpheme'

class Mecab
  def initialize
    @tagger = Tagger.new
  end

  def parse(string)
    Result.new(@tagger.parse_to_lines(string))
  end
end

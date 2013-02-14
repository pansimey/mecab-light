class Mecab
  class Tagger
    def initialize
      @tagger = MeCab::Tagger.new
    end

    def parse_to_lines(string)
      return @tagger.parse(string).sub(/EOS\n$/, '').lines
    end
  end
end

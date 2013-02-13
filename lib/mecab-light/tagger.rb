class Mecab
  class Tagger
    def initialize
      @tagger = MeCab::Tagger.new
    end

    def parse_to_lines(string)
      return @tagger.parse(string).split(/\n/)[0..-2]
    end
  end
end

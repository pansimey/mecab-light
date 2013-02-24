class Mecab
  class Tagger
    def initialize
      @tagger = MeCab::Tagger.new
    end

    def parse_to_enum(string)
      return @tagger.parse(string).sub(/EOS\n$/, '').each_line
    end
  end
end

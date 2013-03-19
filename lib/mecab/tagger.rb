module MeCab
  class Tagger
    def parse_to_enum(string)
      self.parse(string).sub(/EOS\n$/, '').each_line
    end
  end
end

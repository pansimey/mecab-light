module MeCab
  module Light
    class Tagger
      def initialize
        @mecab = Binding.new('')
      end

      def parse(string)
        Result.new(parse_to_enum(string))
      end

      private
      def parse_to_enum(string)
        @mecab.parse_to_s(string).sub(/EOS\n$/, '').each_line
      end
    end
  end
end

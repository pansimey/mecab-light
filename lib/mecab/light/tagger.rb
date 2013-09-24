module MeCab
  module Light
    class Tagger
      def initialize
        @mecab = Binding.new('')
      end

      def parse(string)
        Result.new(parse_to_s(string))
      end

      private
      def parse_to_s(string)
        @mecab.parse_to_s(string).sub(/EOS\n$/, '')
      end
    end
  end
end

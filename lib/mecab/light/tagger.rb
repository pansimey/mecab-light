module MeCab
  module Light
    class Tagger
      def initialize
        @mecab = Binding.mecab_new2('')
      end

      def parse(string)
        Result.new(parse_to_enum(string))
      end

      private
      def parse_to_enum(string)
        parse_to_str(string).sub(/EOS\n$/, '').each_line
      end

      def parse_to_str(string)
        encoding = Encoding.default_external
        Binding.mecab_sparse_tostr(@mecab, string).force_encoding(encoding)
      end
    end
  end
end

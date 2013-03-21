module MeCab
  module Light
    class Tagger
      def initialize(*args)
        @core_tagger = MeCab::Tagger.new(*args)
      end

      def parse(string)
        Result.new(parse_to_enum(string))
      end

      private
      def parse_to_enum
        @core_tagger.parse(string).sub(/EOS\n$/, '').each_line
      end
    end
  end
end

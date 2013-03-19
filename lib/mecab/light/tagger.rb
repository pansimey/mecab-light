module MeCab
  module Light
    class Tagger
      def initialize(*args)
        @core_tagger = MeCab::Tagger.new(*args)
      end

      def parse(string)
        Result.new(@core_tagger.parse_to_enum(string))
      end
    end
  end
end

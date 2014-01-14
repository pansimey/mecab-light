module MeCab
  module Light
    class Morpheme
      def initialize(line)
        @to_s = line.chomp
        @surface, @feature = @to_s.split(/\t/)
      end

      alias to_s_orig to_s
      private :to_s_orig
      attr_reader :surface, :feature, :to_s

      def inspect
        to_s_orig.sub(/>$/, " #{@to_s}>")
      end
    end
  end
end

module MeCab
  module Light
    class Result
      include Enumerable

      def initialize(parsed)
        @to_s = parsed
        @morphemes = parsed.each_line.map { |line| Morpheme.new(line) }
      end

      def to_one_line
        @morphemes.map do |morpheme|
          morpheme.surface
        end.join(' ')
      end

      alias to_s_orig to_s
      private :to_one_line, :to_s_orig
      attr_reader :to_s

      def inspect
        to_s_orig.sub(/>$/, " #{to_one_line}>")
      end

      def each(&block)
        if block_given?
          @morphemes.each(&block)
          self
        else
          self.to_enum { @morphemes.size }
        end
      end

      def [](nth)
        @morphemes[nth]
      end

      alias at []

      def size
        @morphemes.size
      end

      alias length size
    end
  end
end

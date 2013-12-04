module MeCab
  module Light
    class Result
      include Enumerable

      def initialize(parsed)
        @morphemes = parsed.each_line.map { |line| Morpheme.new(line) }
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

      def size
        @morphemes.size
      end

      alias at []
      alias length size
    end
  end
end

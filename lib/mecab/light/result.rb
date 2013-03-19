module MeCab
  module Light
    class Result
      include Enumerable
      def initialize(line_enum)
        @morphemes = line_enum.map{|line| Morpheme.new(line) }
      end

      def each(&block)
        if block_given?
          @morphemes.each(&block)
          self
        else
          self.to_enum
        end
      end

      def [](nth)
        @morphemes[nth]
      end

      alias at []
    end
  end
end

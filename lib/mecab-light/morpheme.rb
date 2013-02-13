class Mecab
  class Morpheme
    def initialize(line)
      @surface, @feature = line.split(/\t/)
    end
    attr_reader :surface, :feature
  end
end

class Mecab
  class Morpheme
    def initialize(line)
      @surface, @feature = line.chomp.split(/\t/)
    end
    attr_reader :surface, :feature
  end
end

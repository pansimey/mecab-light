require 'spec_helper'

describe MeCab::Light::Morpheme, :class do
  subject do
    MeCab::Light::Morpheme.new(line)
  end

  context 'initialized with "surface\tfeature\n"' do
    let :line do
      "surface\tfeature\n"
    end

    specify do
      expect(subject).to respond_to(:surface).with(0).arguments
    end

    specify do
      expect(subject).to respond_to(:feature).with(0).arguments
    end

    describe :surface do
      let :surface do
        subject.surface
      end

      specify do
        expect(surface).to eq('surface')
      end

      describe :encoding do
        let :encoding do
          surface.encoding
        end

        specify do
          expect(encoding).to eq(Encoding::UTF_8)
        end
      end
    end

    describe :feature do
      let :feature do
        subject.feature
      end

      specify do
        expect(feature).to eq('feature')
      end

      describe :encoding do
        let :encoding do
          feature.encoding
        end

        specify do
          expect(encoding).to eq(Encoding::UTF_8)
        end
      end
    end

    describe :to_s do
      let :to_s do
        subject.to_s
      end

      specify do
        expect(to_s).to eq("surface\tfeature")
      end

      describe :encoding do
        let :encoding do
          to_s.encoding
        end

        specify do
          expect(encoding).to eq(Encoding::UTF_8)
        end
      end
    end

    describe :inspect do
      let :inspect do
        subject.inspect
      end

      specify do
        pattern = /^#<MeCab::Light::Morpheme:\w+ surface\tfeature>$/
        expect(inspect).to match(pattern)
      end
    end
  end
end

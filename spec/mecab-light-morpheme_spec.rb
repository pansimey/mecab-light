require 'spec_helper'

describe MeCab::Light::Morpheme do
  let(:line) { "surface\tfeature\n" }
  let(:morpheme) { MeCab::Light::Morpheme.new(line) }

  context 'the class' do
    it { expect(MeCab::Light::Morpheme).to respond_to(:new).with(1).argument }
  end

  context 'an instance initialized with "surface\tfeature\n"' do
    it { expect(morpheme).to respond_to(:surface).with(0).arguments }
    it { expect(morpheme).to respond_to(:feature).with(0).arguments }

    context 'surface' do
      it { expect(morpheme.surface).to eq('surface') }

      context 'encoding' do
        it { expect(morpheme.surface.encoding).to eq(Encoding::UTF_8) }
      end
    end

    context 'feature' do
      it { expect(morpheme.feature).to eq('feature') }

      context 'encoding' do
        it { expect(morpheme.feature.encoding).to eq(Encoding::UTF_8) }
      end
    end
  end
end

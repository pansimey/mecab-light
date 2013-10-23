require 'spec_helper'

describe MeCab::Light::Morpheme do
  describe 'the class' do
    subject { MeCab::Light::Morpheme }

    it { expect(subject).to respond_to(:new).with(1).argument }
  end

  describe 'an instance' do
    let(:morpheme) { MeCab::Light::Morpheme.new(line) }

    subject { morpheme }

    context 'initialized with "surface\tfeature\n"' do
      let(:line) { "surface\tfeature\n" }

      it { expect(subject).to respond_to(:surface).with(0).arguments }
      it { expect(subject).to respond_to(:feature).with(0).arguments }

      describe 'surface' do
        subject { morpheme.surface }

        it { expect(subject).to eq('surface') }

        describe 'encoding' do
          subject { morpheme.surface.encoding }

          it { expect(subject).to eq(Encoding::UTF_8) }
        end
      end

      describe 'feature' do
        subject { morpheme.feature }

        it { expect(subject).to eq('feature') }

        describe 'encoding' do
          subject { morpheme.feature.encoding }

          it { expect(subject).to eq(Encoding::UTF_8) }
        end
      end
    end
  end
end

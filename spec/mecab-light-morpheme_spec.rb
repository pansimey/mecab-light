require 'spec_helper'

describe MeCab::Light::Morpheme do
  subject { MeCab::Light::Morpheme }
  it { expect(subject).to respond_to(:new).with(1).argument }

  describe :new do
    subject { new }
    let(:new) { MeCab::Light::Morpheme.new(line) }

    context 'with "surface\tfeature\n"' do
      let(:line) { "surface\tfeature\n" }
      it { expect(subject).to respond_to(:surface).with(0).arguments }
      it { expect(subject).to respond_to(:feature).with(0).arguments }

      describe :surface do
        subject { new.surface }
        it { expect(subject).to eq('surface') }

        describe :encoding do
          subject { new.surface.encoding }
          it { expect(subject).to eq(Encoding::UTF_8) }
        end
      end

      describe :feature do
        subject { new.feature }
        it { expect(subject).to eq('feature') }

        describe :encoding do
          subject { new.feature.encoding }
          it { expect(subject).to eq(Encoding::UTF_8) }
        end
      end
    end
  end
end

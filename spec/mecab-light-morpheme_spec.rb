require 'spec_helper'

describe MeCab::Light::Morpheme do
  describe :new do
    subject { new }

    let :new do
      MeCab::Light::Morpheme.new(line)
    end

    context 'with "surface\tfeature\n"' do
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
        subject { new.surface }

        specify do
          expect(subject).to eq('surface')
        end

        describe :encoding do
          subject { new.surface.encoding }

          specify do
            expect(subject).to eq(Encoding::UTF_8)
          end
        end
      end

      describe :feature do
        subject { new.feature }

        specify do
          expect(subject).to eq('feature')
        end

        describe :encoding do
          subject { new.feature.encoding }

          specify do
            expect(subject).to eq(Encoding::UTF_8)
          end
        end
      end
    end
  end
end

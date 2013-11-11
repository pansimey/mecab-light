require 'spec_helper'

describe MeCab::Light::Tagger do
  before do
    MeCab::Light::Binding.stub(:new).and_return(binding)
    MeCab::Light::Result.stub(:new).and_return(result)
  end

  let(:binding) do
    double(MeCab::Light::Binding,
           parse_to_s: "surface\tfeature\nEOS\n")
  end

  let(:result) do
    double(MeCab::Light::Result)
  end

  describe :new do
    subject { new }
    let(:new) { MeCab::Light::Tagger.new }
    it { expect(subject).to respond_to(:parse).with(1).argument }

    describe :parse do
      subject { new.parse(string) }

      context 'with "surface"' do
        let(:string) { 'surface' }

        it 'should be an instance of MeCab::Light::Result' do
          expect(subject).to eq(result)
        end

        describe MeCab::Light::Result do
          subject { MeCab::Light::Result }

          before do
            new.parse(string)
          end

          it do
            expect(subject).to have_received(:new).with("surface\tfeature\n")
          end
        end

        describe 'an instance of', MeCab::Light::Binding do
          subject { binding }

          before do
            new.parse(string)
          end

          it do
            expect(subject).to have_received(:parse_to_s).with('surface')
          end
        end
      end
    end

    describe MeCab::Light::Binding do
      subject { MeCab::Light::Binding }

      before do
        new
      end

      it do
        expect(subject).to have_received(:new).with('')
      end
    end
  end
end

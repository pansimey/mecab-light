require 'spec_helper'

describe MeCab::Light::Tagger do
  subject { MeCab::Light::Tagger }

  before do
    MeCab::Light::Binding.stub(:new).and_return(binding)
    MeCab::Light::Result.stub(:new).and_return(result)
  end

  let(:binding) do
    double('MeCab::Light::Binding',
           parse_to_s: "surface\tfeature\nEOS\n")
  end

  let(:result) { double('MeCab::Light::Result') }
  it { expect(subject).to respond_to(:new).with(0).arguments }

  describe 'new' do
    subject { new }
    let(:new) { MeCab::Light::Tagger.new }
    it { expect(subject).to respond_to(:parse).with(1).argument }

    describe 'parse' do
      subject { new.parse(string) }

      context 'with "surface"' do
        let(:string) { 'surface' }

        it 'should be an instance of MeCab::Light::Result' do
          expect(subject).to eq(result)
        end

        describe MeCab::Light::Result do
          subject { MeCab::Light::Result }

          after do
            new.parse('surface')
          end

          it 'should receive #new with "surface\tfeature\n"' do
            expect(subject).to receive(:new).with("surface\tfeature\n")
          end
        end

        describe 'a MeCab::Light::Binding object' do
          subject { binding }

          after do
            new.parse('surface')
          end

          it 'should receive #parse_to_s with "surface"' do
            expect(binding).to receive(:parse_to_s).with('surface')
          end
        end
      end
    end

    describe MeCab::Light::Binding do
      subject { MeCab::Light::Binding }

      after do
        MeCab::Light::Tagger.new
      end

      it 'should receive #new with ""' do
        expect(subject).to receive(:new).with('')
      end
    end
  end
end

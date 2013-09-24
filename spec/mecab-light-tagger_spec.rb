require 'spec_helper'

describe MeCab::Light::Tagger do
  let(:binding) { double( parse_to_s: "surface\tfeature\nEOS\n" ) }
  let(:result) { double('MeCab::Light::Result') }
  let(:tagger) { MeCab::Light::Tagger.new }
  before do
    MeCab::Light::Binding.stub(:new).and_return(binding)
    MeCab::Light::Result.stub(:new).and_return(result)
  end

  context 'the class' do
    it { expect(MeCab::Light::Tagger).to respond_to(:new).with(0).arguments }

    context 'new' do
      context 'MeCab::Light::Binding class' do
        after do
          MeCab::Light::Tagger.new
        end

        it 'should receive #new with ""' do
          expect(MeCab::Light::Binding).to receive(:new).with('')
        end
      end
    end
  end

  context 'an instance' do
    it { expect(tagger).to respond_to(:parse).with(1).argument }

    context 'parse with "surface"' do
      it 'should be an instance of MeCab::Light::Result' do
        expect(tagger.parse('surface')).to eq(result)
      end

      context 'MeCab::Light::Result class' do
        after do
          tagger.parse('surface')
        end

        it 'should receive #new with "surface\tfeature\n"' do
          expect(MeCab::Light::Result).to receive(:new).with("surface\tfeature\n")
        end
      end

      context 'a MeCab::Light::Binding object' do
        after do
          tagger.parse('surface')
        end

        it 'should receive #parse_to_s with "surface"' do
          expect(binding).to receive(:parse_to_s).with('surface')
        end
      end
    end
  end
end

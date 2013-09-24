require 'spec_helper'

describe MeCab::Light::Result do
  let(:morpheme) { double('MeCab::Light::Morpheme') }
  let(:result) { MeCab::Light::Result.new("surface\tfeature\n") }
  before do
    MeCab::Light::Morpheme.stub(:new).and_return(morpheme)
  end

  context 'class' do
    it { expect(MeCab::Light::Result).to respond_to(:new).with(1).argument }

    context 'new with "surface\tfeature\n"' do
      context 'MeCab::Light::Morpheme class' do
        after do
          MeCab::Light::Result.new("surface\tfeature\n")
        end

        it 'should receive #new with "surface\tfeature\n"' do
          expect(MeCab::Light::Morpheme).to receive(:new).with("surface\tfeature\n")
        end
      end
    end
  end

  context 'an instance initialized with ""' do
    it { expect(result).to respond_to(:each).with(0).arguments }
    it { expect(result).to be_an(Enumerable) }

    context 'count' do
      it { expect(result.count).to eq(1) }
    end

    context 'each' do
      context 'with block' do
        it 'should return self' do
          expect(result.each{}).to eq(result)
        end
        it { expect { |b| result.each(&b) }.to yield_control }
        it 'should yield with args(MeCab::Light::Morpheme)' do
          expect { |b| result.each(&b) }.to yield_with_args(morpheme)
        end
      end

      context 'without block' do
        it { expect(result.each).to be_an_instance_of(Enumerator) }
      end
    end

    context '[] with 0' do
      it 'should be an instance of Morpheme' do
        expect(result[0]).to eq(morpheme)
      end
    end

    context 'at with 0' do
      it 'should be an instance of Morpheme' do
        expect(result.at(0)).to eq(morpheme)
      end
    end
  end
end

# coding: utf-8

begin
  require 'mecab/light'
rescue LoadError
  puts 'loaded mecab-light but its binding class has not been built.'
  puts 'a dummy binding class will be loaded.'
  class MeCab::Light::Binding; end
end

describe MeCab::Light::Morpheme do
  let(:klass) { MeCab::Light::Morpheme }
  let(:result_line) { "見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\n" }
  let(:instance) { klass.new(result_line) }
  let(:surface) { '見る' }
  let(:feature) { '動詞,自立,*,*,一段,基本形,見る,ミル,ミル' }
  context 'class' do
    it { expect(klass).to respond_to(:new).with(1).argument }
  end
  context 'instance (initialized with the result line of the word "見る")' do
    it { expect(instance).to respond_to(:surface).with(0).arguments }
    it { expect(instance).to respond_to(:feature).with(0).arguments }
    context 'surface' do
      it { expect(instance.surface).to eq(surface) }
      context 'encoding' do
        it { expect(instance.surface.encoding).to eq(Encoding::UTF_8) }
      end
    end
    context 'feature' do
      it { expect(instance.feature).to eq(feature) }
      context 'encoding' do
        it { expect(instance.feature.encoding).to eq(Encoding::UTF_8) }
      end
    end
  end
end
describe MeCab::Light::Result do
  let(:klass) { MeCab::Light::Result }
  let(:result_enum) do
    ["見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\n"].to_enum
  end
  let(:instance) { klass.new(result_enum) }
  let(:c_morpheme) { MeCab::Light::Morpheme }
  context 'class' do
    it { expect(klass).to respond_to(:new).with(1).argument }
  end
  context 'instance (initialized with the result enum of the word "見る")' do
    it { expect(instance).to respond_to(:each).with(0).arguments }
    it { expect(instance).to be_an(Enumerable) }
    context 'count' do
      it { expect(instance.count).to eq(1) }
    end
    context 'each' do
      context 'with block' do
        it { expect(instance.each{}).to eq(instance) }
        it { expect { |b| instance.each(&b) }.to yield_control }
        it { expect { |b| instance.each(&b) }.to yield_with_args(c_morpheme) }
      end
      context 'without block' do
        it { expect(instance.each).to be_an_instance_of(Enumerator) }
      end
    end
    context '[] with 0' do
      it { expect(instance[0]).to be_an_instance_of(c_morpheme) }
    end
    context 'at with 0' do
      it { expect(instance.at(0)).to be_an_instance_of(c_morpheme) }
    end
  end
end
describe MeCab::Light::Tagger do
  let(:result_str) { "見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\nEOS\n" }
  let(:binding) { double( parse_to_s: result_str ) }
  before { MeCab::Light::Binding.stub(:new).and_return(binding) }
  let(:klass) { MeCab::Light::Tagger }
  let(:instance) { klass.new }
  let(:c_result) { MeCab::Light::Result }
  context 'class' do
    it { expect(klass).to respond_to(:new).with(0).arguments }
    context 'new' do
      context 'MeCab::Light::Binding class' do
        it 'should receive #new with ""' do
          expect(MeCab::Light::Binding).to receive(:new).with('')
        end
        after { klass.new }
      end
    end
  end
  context 'instance' do
    it { expect(instance).to respond_to(:parse).with(1).argument }
    context 'parse with "見る"' do
      it { expect(instance.parse('見る')).to be_an_instance_of(c_result) }
      context 'a MeCab::Light::Binding object' do
        it 'should receive #parse_to_s with "見る"' do
          expect(binding).to receive(:parse_to_s).with('見る')
        end
        after { instance.parse('見る') }
      end
    end
  end
end

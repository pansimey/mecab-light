# coding: utf-8

require 'rspec'
require 'mecab-light'

describe Mecab::Morpheme do
  context 'when initialized with the result line of the word "見る"' do
    before do
      @morpheme = Mecab::Morpheme.new(
        "見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル")
    end
    subject { @morpheme }
    its(:surface){ should eq '見る' }
    its(:feature){ should eq '動詞,自立,*,*,一段,基本形,見る,ミル,ミル' }
    describe '#surface' do
      subject { @morpheme.surface }
      its(:encoding){ should be Encoding::UTF_8 }
    end
    describe '#feature' do
      subject { @morpheme.feature }
      its(:encoding){ should be Encoding::UTF_8 }
    end
  end
end
describe Mecab::Result do
  context 'when initialized with the result array of the word "見る"' do
    before do
      @result = Mecab::Result.new(
        ["見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル"])
    end
    subject { @result }
    it { should respond_to :each }
    it { should be_an Enumerable }
    describe '#each' do
      context 'with block' do
        subject { @result.each{} }
        it 'should return self' do
          should be @result
        end
      end
      context 'without block' do
        subject { @result.each }
        it 'should return Enumerator' do
          should be_an_instance_of Enumerator
        end
      end
    end
    describe '#[]' do
      context 'when argument 0' do
        subject { @result[0] }
        it { should be_an_instance_of Mecab::Morpheme }
      end
    end
    describe '#at' do
      context 'when argument 0' do
        subject { @result.at(0) }
        it { should be_an_instance_of Mecab::Morpheme }
      end
    end
  end
end
describe Mecab do
  before { @mecab = Mecab.new }
  subject { @mecab }
  it { should respond_to :parse }
  describe '#parse' do
    context 'when argument "見る"' do
      before { @result = @mecab.parse('見る') }
      it 'should return Mecab::Result object' do
        @result.should be_an_instance_of Mecab::Result
      end
    end
  end
end

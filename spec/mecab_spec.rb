# coding: utf-8

require 'rspec'
begin
  require 'mecab/light'
rescue LoadError
  puts 'loaded mecab-light but MeCab does not exist.'
  puts 'dummy binding will be loaded.'
end

module MeCab
  module Light
    module Binding
      def self.mecab_new2(arg)
        :dummy_mecab
      end

      def self.mecab_sparse_tostr(mecab, string)
        result = "見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\nEOS\n"
        result.force_encoding('ASCII-8BIT')
      end
    end
  end
end

describe MeCab::Light::Morpheme do
  context 'when initialized with the result line of the word "見る"' do
    before do
      @morpheme = MeCab::Light::Morpheme.new(
        "見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\n")
    end
    subject { @morpheme }
    its(:surface){ should eq '見る' }
    its(:feature){ should eq '動詞,自立,*,*,一段,基本形,見る,ミル,ミル' }
    describe 'surface' do
      subject { @morpheme.surface }
      its(:encoding){ should be Encoding::UTF_8 }
    end
    describe 'feature' do
      subject { @morpheme.feature }
      its(:encoding){ should be Encoding::UTF_8 }
    end
  end
end
describe MeCab::Light::Result do
  context 'when initialized with the result Enumerator of the word "見る"' do
    before do
      @result = MeCab::Light::Result.new(
        ["見る\t動詞,自立,*,*,一段,基本形,見る,ミル,ミル\n"].to_enum)
    end
    subject { @result }
    it { should respond_to :each }
    it { should be_an Enumerable }
    its(:count){ should be 1 }
    describe 'each' do
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
    describe '[]' do
      context 'when argument 0' do
        subject { @result[0] }
        it { should be_an_instance_of MeCab::Light::Morpheme }
      end
    end
    describe 'at' do
      context 'when argument 0' do
        subject { @result.at(0) }
        it { should be_an_instance_of MeCab::Light::Morpheme }
      end
    end
  end
end
describe MeCab::Light::Tagger do
  before { @tagger = MeCab::Light::Tagger.new }
  subject { @tagger }
  it { should respond_to :parse }
  describe 'parse' do
    context 'when argument "見る"' do
      before { @result = @tagger.parse('見る') }
      subject { @result }
      it 'should return MeCab::Light::Result object' do
        should be_an_instance_of MeCab::Light::Result
      end
      its(:count){ should be 1 }
      describe 'MeCab::Light::Result (returned)' do
        context '[0]' do
          before { @morpheme = @result[0] }
          subject { @morpheme }
          it 'should return MeCab::Light::Morpheme object' do
            should be_an_instance_of MeCab::Light::Morpheme
          end
          describe 'MeCab::Light::Morpheme (returned)' do
            context 'surface' do
              subject { @morpheme.surface }
              it { should eq '見る' }
            end
          end
        end
      end
    end
  end
end

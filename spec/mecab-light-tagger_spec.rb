require 'spec_helper'

describe MeCab::Light::Tagger do
  before do
    MeCab::Light::Binding.stub(:new).and_return(binding)
    MeCab::Light::Result.stub(:new).and_return(result)
  end

  let :binding do
    double(MeCab::Light::Binding,
           parse_to_s: "surface\tfeature\nEOS\n")
  end

  let :result do
    double(MeCab::Light::Result)
  end

  specify do
    expect(subject).to respond_to(:parse).with(1).argument
  end

  describe :parse do
    let :parse do
      subject.parse(string)
    end

    context 'with "surface"' do
      let :string do
        'surface'
      end

      specify 'should be an instance of MeCab::Light::Result' do
        expect(parse).to eq(result)
      end
    end
  end
end

require 'spec_helper'

describe MeCab::Light::Result do
  before do
    MeCab::Light::Morpheme.stub(:new).and_return(morpheme)
  end

  let :morpheme do
    double(MeCab::Light::Morpheme,
           surface: 'surface',
           feature: 'feature')
  end

  subject do
    MeCab::Light::Result.new(parsed)
  end

  context 'initialized with "surface\tfeature\n"' do
    let :parsed do
      "surface\tfeature\n"
    end

    specify do
      expect(subject).to respond_to(:each).with(0).arguments
    end

    specify do
      expect(subject).to be_an(Enumerable)
    end

    describe :each do
      let :each do
        subject.each(&block)
      end

      context 'with block' do
        let :block do
          lambda { |morpheme| }
        end

        it 'should return self' do
          expect(each).to eq(subject)
        end

        specify do
          expect { |b| subject.each(&b) }.to yield_control
        end

        it 'should yield with args(MeCab::Light::Morpheme)' do
          expect { |b| subject.each(&b) }.to yield_with_args(morpheme)
        end
      end

      context 'without block' do
        let :block do
          nil
        end

        specify do
          expect(each).to be_an_instance_of(Enumerator)
        end

        describe :size do
          let :size do
            each.size
          end

          specify do
            expect(size).to eq(1)
          end
        end
      end
    end

    describe :count do
      let :count do
        subject.count
      end

      specify do
        expect(count).to eq(1)
      end
    end

    describe :size do
      let :size do
        subject.size
      end

      specify do
        expect(size).to eq(1)
      end
    end

    describe :length do
      let :length do
        subject.length
      end

      specify do
        expect(length).to eq(1)
      end
    end

    describe :[] do
      let :at_literal do
        subject[nth]
      end

      context 'with 0' do
        let :nth do
          0
        end

        it 'should be an instance of Morpheme' do
          expect(at_literal).to eq(morpheme)
        end
      end
    end

    describe :at do
      let :at do
        subject.at(nth)
      end

      context 'with 0' do
        let :nth do
          0
        end

        it 'should be an instance of Morpheme' do
          expect(at).to eq(morpheme)
        end
      end
    end

    describe :inspect do
      let :inspect do
        subject.inspect
      end

      specify do
        expect(inspect).to match(/^#<MeCab::Light::Result:\w+ surface>$/)
      end
    end
  end
end

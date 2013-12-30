require 'spec_helper'

describe MeCab::Light::Result do
  before do
    MeCab::Light::Morpheme.stub(:new).and_return(morpheme)
  end

  let(:morpheme) { double(MeCab::Light::Morpheme) }

  describe :new do
    subject { new }
    let(:new) { MeCab::Light::Result.new(parsed) }

    context 'with "surface\tfeature\n"' do
      let(:parsed) { "surface\tfeature\n" }

      specify do
        expect(subject).to respond_to(:each).with(0).arguments
      end

      specify do
        expect(subject).to be_an(Enumerable)
      end

      describe :each do
        subject { new.each(&block) }

        context 'with block' do
          let(:block) { lambda { |morpheme| } }

          it 'should return self' do
            expect(subject).to eq(new)
          end

          specify do
            expect { |b| new.each(&b) }.to yield_control
          end

          it 'should yield with args(MeCab::Light::Morpheme)' do
            expect { |b| new.each(&b) }.to yield_with_args(morpheme)
          end
        end

        context 'without block' do
          let(:block) { nil }

          specify do
            expect(subject).to be_an_instance_of(Enumerator)
          end

          describe :size do
            subject { new.each.size }

            specify do
              expect(subject).to eq(1)
            end
          end
        end
      end

      describe :count do
        subject { new.count }

        specify do
          expect(subject).to eq(1)
        end
      end

      describe :size do
        subject { new.size }

        specify do
          expect(subject).to eq(1)
        end
      end

      describe :length do
        subject { new.length }

        specify do
          expect(subject).to eq(1)
        end
      end

      describe :[] do
        subject { new[nth] }

        context 'with 0' do
          let(:nth) { 0 }

          it 'should be an instance of Morpheme' do
            expect(subject).to eq(morpheme)
          end
        end
      end

      describe :at do
        subject { new.at(nth) }

        context 'with 0' do
          let(:nth) { 0 }

          it 'should be an instance of Morpheme' do
            expect(subject).to eq(morpheme)
          end
        end
      end

      describe MeCab::Light::Morpheme do
        subject { MeCab::Light::Morpheme }

        before do
          new
        end

        specify do
          expect(subject).to have_received(:new).with("surface\tfeature\n")
        end
      end
    end
  end
end

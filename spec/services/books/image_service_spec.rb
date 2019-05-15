require 'rails_helper'

RSpec.describe Books::ImageService do
  subject(:image_service) { described_class.new(book) }

  let(:book) { create(:book, :attach_cover) }

  describe '#get_cover' do
    context 'book has a cover' do
      Books::ImageService::COVER_TYPES.values.each do |type|
        it "type is #{type}" do
          expect(image_service.get_cover(type)).to be_a ActiveStorage::Variant
        end
      end
    end

    context 'book does not have a cover' do
      let(:book) { create(:book) }
      let(:default_cover_path) { Books::ImageService::COVERS_DIR + Books::ImageService::DEFAULT_COVER }

      Books::ImageService::COVER_TYPES.values.each do |type|
        it "type is #{type}" do
          expect(image_service.get_cover(type)).to eq default_cover_path
        end
      end
    end
  end

  describe '#get_class_list' do
    let(:image_classes) { Books::ImageService::IMAGE_CLASSES }

    context 'shadow is required' do
      let(:shadow) { true }
      let(:class_list) { "#{image_classes[:shadow]} #{image_classes[:thubmnail]}" }

      it { expect(image_service.get_class_list(shadow)).to eq class_list }
    end

    context 'shadow is not required' do
      let(:shadow) { false }
      let(:class_list) { " #{image_classes[:thubmnail]}" }

      it { expect(image_service.get_class_list(shadow)).to eq class_list }
    end
  end
end

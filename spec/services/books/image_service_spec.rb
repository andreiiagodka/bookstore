require 'rails_helper'
require 'pry'
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
end

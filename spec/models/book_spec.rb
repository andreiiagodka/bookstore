require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal).with_options(precision: 12, scale: 2) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:publication_year).of_type(:integer) }
    it { is_expected.to have_db_column(:height).of_type(:float) }
    it { is_expected.to have_db_column(:width).of_type(:float) }
    it { is_expected.to have_db_column(:depth).of_type(:float) }
    it { is_expected.to have_db_column(:material).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'attachments' do
    let(:book) { create(:book, :attach_cover, :attach_images) }

    it '#cover' do
      expect(book.cover).to be_attached
    end

    it '#images' do
      expect(book.images).to be_attached
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:book_authors) }
    it { is_expected.to have_many(:book_categories).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:book_categories) }
    it { is_expected.to have_many(:order_books).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:order_books) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'scopes' do
    it 'orders by created_at desc' do
      expect(Book.created_at_desc).to eq Book.order('created_at desc')
    end

    it 'orders by popularity desc' do
      expect(Book.popularity_desc).to eq Book.order('created_at desc')
    end

    it 'orders by name asc' do
      expect(Book.name_asc).to eq Book.order('name')
    end

    it 'orders by name desc' do
      expect(Book.name_desc).to eq Book.order('name desc')
    end

    it 'orders by price asc' do
      expect(Book.price_asc).to eq Book.order('price')
    end

    it 'orders by price desc' do
      expect(Book.price_desc).to eq Book.order('price desc')
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

require 'rails_helper'

RSpec.describe Books::GetCategoryBooksService do
  let(:get_category_books_service) { described_class.new(books, category_id) }

  let(:book_first) { create(:book) }
  let(:book_second) { create(:book) }
  let(:books) { [book_first, book_second] }
  let(:category) { create(:category, books: [book_first]) }

  context 'category id is set' do
    let(:category_id) { category.id }

    it do
      allow(Category).to receive(:find_by).and_return(category)
      expect(get_category_books_service.call).to eq category.books
    end
  end

  context 'category id is not set' do
    let(:category_id) { nil }

    it do
      expect(get_category_books_service.call).to eq books
    end
  end
end

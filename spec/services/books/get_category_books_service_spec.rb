require 'rails_helper'

RSpec.describe Books::GetCategoryBooksService do
  let(:get_category_books_service) { described_class.new(books, params) }

  let(:books) { create_list(:book, 3) }
  let(:category_books) { create_list(:book, 3) }
  let(:category) { create(:category, books: category_books) }
  let(:filter) { Filtering::BOOK_FILTERING_ORDER.keys.drop(1).sample }

  context 'category id and filter are set' do
    let(:params) { { category_id: category.id, filter: filter } }

    it do
      allow(Category).to receive(:find_by).and_return(category)
      expect(get_category_books_service.call).to eq category.books.public_send(filter)
    end
  end
end

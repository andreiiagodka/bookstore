require 'rails_helper'

RSpec.describe BookDecorator do
  let(:book) { create(:book, :attach_author, :attach_category).decorate }

  describe '#authors_as_string' do
    let(:book_author) { book.authors.first.name }

    it { expect(book.authors_as_string).to include book_author }
  end

  describe '#categories_as_string' do
    let(:book_category) { book.categories.first.name }

    it { expect(book.categories_as_string).to include book_category }
  end

  describe 'description' do
    let(:length) { BookDecorator::DESCRIPTION_LENGTH }
    let(:end_range) { BookDecorator::DESCRIPTION_END_RANGE }

    it '#first_sentence_description' do
      expect(book.first_sentence_description).to eq book.description.split('.').first
    end

    it '#short_description' do
      expect(book.short_description.size).to eq length[:short]
    end

    it '#medium_description' do
      expect(book.medium_description.size).to eq length[:medium]
    end

    it '#end_of_description' do
      expect(book.end_of_description).to eq book.description[end_range]
    end
  end
end

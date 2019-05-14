class PagesController < ApplicationController
  decorates_assigned :latest_books, :best_sellers

  LATEST_BOOKS_QUANTITY = 3

  def home
    @latest_books = Book.last(LATEST_BOOKS_QUANTITY)
    @best_sellers = Books::GetBestSellersService.new.call
  end
end

class PagesController < ApplicationController
  decorates_assigned :latest_books, :best_sellers

  LATEST_BOOKS_QUANTITY = 3
  BEST_SELLERS_QUANTITY = 4

  def home
    @latest_books = Book.order(created_at: :desc).limit(LATEST_BOOKS_QUANTITY)
    @best_sellers = Book.all.sample(BEST_SELLERS_QUANTITY)
  end
end

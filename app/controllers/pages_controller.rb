class PagesController < ApplicationController
  LATEST_BOOKS_QUANTITY = 3
  BEST_SELLERS_QUANTITY = 4

  def home
    @latest_books = Book.limit(LATEST_BOOKS_QUANTITY).decorate
    @best_sellers = Book.limit(BEST_SELLERS_QUANTITY).order('id desc').decorate
  end
end

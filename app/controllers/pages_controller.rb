class PagesController < ApplicationController
  authorize_resource class: false

  LATEST_BOOKS_QUANTITY = 3
  BEST_SELLERS_QUANTITY = 4

  decorates_assigned :latest_books, :best_sellers

  def home
    @latest_books = Book.limit(LATEST_BOOKS_QUANTITY)
    @best_sellers = Book.limit(BEST_SELLERS_QUANTITY).order('id desc')
  end
end

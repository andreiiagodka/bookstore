class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12

  include Rectify::ControllerHelpers
  include Pagy::Backend

  decorates_assigned :books

  def index
    intialize_book_presenter
    @pagy, @books = pagy(Book.all, items: BOOKS_PER_PAGE)
  end

  private

  def intialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all)
  end
end

class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12

  include Rectify::ControllerHelpers
  include Pagy::Backend

  before_action :set_filter

  decorates_assigned :books

  def index
    intialize_book_presenter
    @pagy, @books = pagy(Book.order_by_filter(@filter), items: BOOKS_PER_PAGE)
  end

  private

  def intialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all)
  end

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter].to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end
end

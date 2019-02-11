class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12

  include Rectify::ControllerHelpers
  include Pagy::Backend

  before_action :set_scope
  before_action :set_order_filter

  decorates_assigned :selected_books, :book

  def index
    intialize_book_presenter
    @pagy, @selected_books = pagy(@books.by_order_filter(@order_filter), items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  private

  def set_scope
    @books = params[:category_id] ? Category::find_by(id: params[:category_id]).books : Book.all
  end

  def set_order_filter
    @order_filter = Book::ORDER_FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_ORDER_FILTER
  end

  def intialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all)
  end
end

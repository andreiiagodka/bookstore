class BooksController < ApplicationController
  include Rectify::ControllerHelpers

  def index
    initialize_book_presenter
    @books = Book.limit(12).decorate
  end

  private

  def initialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all).attach_controller(self)
  end
end

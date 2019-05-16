class BooksController < ApplicationController
  load_and_authorize_resource

  BOOKS_PER_PAGE = 12

  include Filtering
  include Pagy::Backend

  decorates_assigned :selected_books, :book

  def index
    @scoped_books = Books::GetCategoryBooksService.new(@books, params).call
    @pagy, @selected_books = pagy(@scoped_books, items: BOOKS_PER_PAGE)
  end
end

class BooksController < ApplicationController
  load_and_authorize_resource

  BOOKS_PER_PAGE = 12

  include Filtering
  include Pagy::Backend

  decorates_assigned :selected_books, :book

  def index
    @scoped_books = Books::GetCategoryBooksService.new(@books, params[:category_id]).call
    @pagy, @selected_books = pagy(@scoped_books.public_send(get_filter), items: BOOKS_PER_PAGE)
  end

  def show; end

  private

  def get_filter
    @filter = BOOK_FILTERING_ORDER.include?(params[:filter]&.to_sym) ? params[:filter] : DEFAULT_BOOK_FILTERING_ORDER
  end
end

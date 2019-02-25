class BooksController < ApplicationController
  load_and_authorize_resource

  BOOKS_PER_PAGE = 12

  include Rectify::ControllerHelpers
  include Pagy::Backend

  before_action :get_category_books, only: [:index]
  before_action :set_filtering_order, only: [:index]
  before_action :intialize_book_presenter, only: [:index]

  decorates_assigned :selected_books, :book

  def index
    @pagy, @selected_books = pagy(@scoped_books.by_filtering_order(@filtering_order), items: BOOKS_PER_PAGE)
  end

  def show; end

  private

  def get_category_books
    @scoped_books = Books::CategoryBooksService.new(@books, params[:category_id]).call
  end

  def set_filtering_order
    @filtering_order = Books::FilteringOrderService.new(params[:filter]).call
  end

  def intialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all)
  end
end

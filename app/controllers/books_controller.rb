class BooksController < ApplicationController
  load_and_authorize_resource

  BOOKS_PER_PAGE = 12

  include Rectify::ControllerHelpers
  include Pagy::Backend
  include FiltersHelper

  before_action :set_filtering_order, only: [:index]
  before_action :intialize_book_presenter, only: [:index]

  decorates_assigned :selected_books, :book

  def index
    @pagy, @selected_books = pagy(@books.by_filtering_order(@filtering_order), items: BOOKS_PER_PAGE)
  end

  def show; end

  private

  def set_filtering_order
    @filtering_order = BooksFilteringOrderService.new(params[:filter]).call
  end

  def intialize_book_presenter
    @book_presenter = BookPresenter.new(books: Book.all)
  end
end

class BooksController < ApplicationController
  load_and_authorize_resource

  BOOKS_PER_PAGE = 12

  include Pagy::Backend

  decorates_assigned :selected_books, :book

  def index
    @scoped_books = Books::GetCategoryBooksService.new(@books, params[:category_id]).call
    @filtering_order = Books::FilteringService.new(params[:filter]).call
    @pagy, @selected_books = pagy(@scoped_books.by_filter(@filtering_order), items: BOOKS_PER_PAGE)
  end

  def show; end
end

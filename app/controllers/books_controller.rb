class BooksController < ApplicationController
  def index
    @books = Book.limit(12).decorate
  end
end

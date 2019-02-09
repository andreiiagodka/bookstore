class BookPresenter < Rectify::Presenter
  attribute :books, Book

  def total_quantity
    books.count
  end
end

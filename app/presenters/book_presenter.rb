class BookPresenter < Rectify::Presenter
  def all_books_quantity
    @all_books_quantity ||= Book.all.count
  end
end

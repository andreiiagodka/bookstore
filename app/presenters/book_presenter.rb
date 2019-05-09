class BookPresenter < Rectify::Presenter
  def get_all_books_amount
    @get_all_books_amount ||= Book.all.count
  end
end

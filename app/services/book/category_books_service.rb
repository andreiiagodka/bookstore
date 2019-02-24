class Book::CategoryBooksService
  def initialize(books, category_id)
    @books = books
    @category_id = category_id
  end

  def call
    @category_id ? Category.find_by(id: @category_id).books : @books
  end
end

class CategoryDecorator < Draper::Decorator
  delegate_all

  def count_books
    books.count
  end
end

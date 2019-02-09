class CategoryDecorator < Draper::Decorator
  delegate_all

  def books_count
    books.count
  end
end

class OrderPresenter < Rectify::Presenter
  def count_order_books_quantity
    current_order ? current_order.order_books.count : nil
  end
end

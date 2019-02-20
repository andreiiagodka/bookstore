class OrderBookDecorator < Draper::Decorator
  delegate_all

  def count_subtotal_price
    book.price * quantity
  end
end

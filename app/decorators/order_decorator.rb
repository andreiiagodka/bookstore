class OrderDecorator < Draper::Decorator
  delegate_all

  def count_subtotal_price
    order_books.sum(&:subtotal_price)
  end

  def count_discount
    total_price/coupon.discount_percent
  end
end

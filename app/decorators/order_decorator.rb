class OrderDecorator < Draper::Decorator
  delegate_all

  def count_total_price
    count_subtotal_price - count_discount
  end

  def count_subtotal_price
    order_books.sum(&:subtotal_price)
  end

  def count_discount
    coupon ? (count_subtotal_price/coupon.discount_percent).round : 0
  end
end

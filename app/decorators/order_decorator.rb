class OrderDecorator < Draper::Decorator
  delegate_all

  decorates_association :order_books

  def count_total_price
    count_subtotal_price - count_discount
  end

  def count_subtotal_price
    order_books.sum(&:count_subtotal_price)
  end

  def count_discount
    coupon ? (count_subtotal_price/coupon.discount_percent).round : 0
  end

  def count_books_quantity
    order_books.count
  end
end

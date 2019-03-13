class OrderDecorator < Draper::Decorator
  delegate_all

  decorates_association :order_books

  def total_price
    subtotal_price - discount
  end

  def subtotal_price
    order_books.sum(&:subtotal_price)
  end

  def discount
    coupon ? count_discount : 0
  end

  def books_quantity
    order_books.count
  end

  private

  def count_discount
    (subtotal_price/coupon.discount_percent).round
  end
end

class OrderDecorator < Draper::Decorator
  delegate_all

  decorates_association :order_books

  def total_price
    subtotal_price - discount_price + delivery_price
  end

  def subtotal_price
    order_books.sum(&:subtotal_price)
  end

  def discount_price
    coupon ? count_discount_price : 0
  end

  def delivery_price
    delivery ? delivery.price : 0
  end

  def books_quantity
    order_books.count
  end

  private

  def count_discount_price
    (subtotal_price/coupon.discount_percent).round
  end
end

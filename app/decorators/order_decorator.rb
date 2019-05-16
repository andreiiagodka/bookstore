class OrderDecorator < Draper::Decorator
  CREATION_DATE_FORMAT = '%B %d, %Y'.freeze
  COMPLETION_DATE_FORMAT = '%Y-%m-%d'.freeze

  delegate_all

  def subtotal_price
    order_books.decorate.sum(&:subtotal_price)
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

  def creation_date
    updated_at.strftime(CREATION_DATE_FORMAT)
  end

  def completion_date
    updated_at.strftime(COMPLETION_DATE_FORMAT)
  end

  def status_title
    status.capitalize.tr('_', ' ')
  end

  private

  def count_discount_price
    (subtotal_price / coupon.discount_percent).round
  end
end

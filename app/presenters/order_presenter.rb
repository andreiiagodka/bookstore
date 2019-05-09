class OrderPresenter < Rectify::Presenter
  def initialize(order)
    @order = order.decorate
  end

  def total_price
    @order.subtotal_price - @order.discount_price + @order.delivery_price
  end
end

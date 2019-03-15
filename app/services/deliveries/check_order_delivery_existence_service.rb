class Deliveries::CheckOrderDeliveryExistenceService
  def initialize(order)
    @order = order
  end

  def call
    @order.delivery
  end
end

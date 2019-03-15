class Deliveries::CheckOrderDeliveriesExistenceService
  def initialize(order)
    @order = order
  end

  def call
    @order.deliver.exists?
  end
end

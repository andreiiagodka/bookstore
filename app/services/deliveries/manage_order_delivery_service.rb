class Deliveries::ManageOrderDeliveryService
  def initialize(order, params)
    @order = order
    @delivery_id = params[:delivery_id]
  end

  def call
    @order.update(delivery_id: @delivery_id)
  end
end

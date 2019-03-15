class Deliveries::ManageOrderDeliveryService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    @order.update(order_delivery_params)
  end

  private

  def order_delivery_params
    @params.permit(:delivery_id)
  end
end

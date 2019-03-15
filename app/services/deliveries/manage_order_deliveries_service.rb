class Deliveries::ManageOrderDeliveriesService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    @order.delivery ? @order.update(order_delivery_params) : @order.create(order_delivery_params)
  end

  private

  def order_delivery_params
    @params.permit(:delivery_id)
  end
end

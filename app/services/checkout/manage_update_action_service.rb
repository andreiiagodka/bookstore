class Checkout::ManageUpdateActionService
  def initialize(order, params, session)
    @order = order
    @params = params
    @session = session
  end

  def call(step)
    public_send(step)
  end

  def addresses
    Addresses::ManageOrderAddressService.new(@order, order_params, @params[:use_billing]).call
  end

  def delivery
    Deliveries::ManageOrderDeliveryService.new(@order, order_params).call
  end

  def payment
    CreditCards::ManageOrderCreditCardService.new(@order, order_params).call
  end

  def confirm
    @order.complete!
    OrderMailer.completed_order(@order).deliver
    Orders::ClearCurrentOrderSessionService.new(@session).call
  end

  private

  def order_params
    @params.fetch(:order)
  end
end

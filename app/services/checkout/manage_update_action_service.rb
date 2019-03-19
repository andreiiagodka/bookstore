class Checkout::ManageUpdateActionService
  def initialize(step, order, params, session)
    @step = step
    @order = order
    @params = params
    @session = session
  end

  def call
    public_send(@step)
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
    Orders::CreateNumberService.new(@order).call
    Orders::ClearCurrentOrderSessionService.new(@session).call
  end

  private

  def order_params
    @params.require(:order)
  end
end

class Checkout::ManageUpdateActionService
  def initialize(order, params, session)
    @order = order
    @params = params
    @session = session
  end

  def call(step)
    case step
    when CheckoutController::STEPS[:addresses] then addresses
    when CheckoutController::STEPS[:delivery] then delivery
    when CheckoutController::STEPS[:payment] then payment
    when CheckoutController::STEPS[:confirm] then confirm
    end
  end

  def authentication
    @order.update(user: @user) unless @order.user
  end

  def addresses
    Addresses::ManageOrderAddressService.new(@order, order_params, @params[:use_billing]).call
  end

  def delivery
    @order.update(delivery_id: order_params[:delivery_id])
  end

  def payment
    CreditCardForm.new(credit_card_params).save(@order) if credit_card_params
  end

  def confirm
    @order.complete!
    OrderMailer.completed_order(@order).deliver
    @session.delete(:order_id)
  end

  private

  def order_params
    @params.fetch(:order)
  end

  def credit_card_params
    order_params.fetch(:credit_card).slice(:number, :name, :expire_date, :cvv).to_enum.to_h
  end
end

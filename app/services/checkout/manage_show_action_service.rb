class Checkout::ManageShowActionService
  attr_reader :order, :temporary_password, :billing_address, :shipping_address,
              :deliveries, :credit_card, :order_delivery

  def initialize(order, user)
    @order = order
    @user = user
  end

  def call(step)
    case step
    when CheckoutController::STEPS[:authentication] then authentication
    when CheckoutController::STEPS[:addresses] then addresses
    when CheckoutController::STEPS[:delivery] then delivery
    when CheckoutController::STEPS[:payment] then payment
    when CheckoutController::STEPS[:confirm] then confirm
    when CheckoutController::STEPS[:complete] then complete
    end
  end

  def authentication
    @temporary_password = Devise.friendly_token
  end

  def addresses
    @billing_address = AddressForm.new(@order.addresses.billing.first&.attributes)
    @shipping_address = AddressForm.new(@order.addresses.shipping.first&.attributes)
  end

  def delivery
    @deliveries = Delivery.all
  end

  def payment
    @credit_card = CreditCardForm.new(@order.credit_card&.attributes)
  end

  def confirm
    @billing_address = @order.addresses.billing.first.decorate
    @shipping_address = @order.addresses.shipping.first.decorate
    @order_delivery = @order.delivery
    @credit_card = @order.credit_card.decorate
  end

  def complete
    @order = @user.orders.last.decorate
    @billing_address = @order.addresses.billing.first.decorate
  end
end

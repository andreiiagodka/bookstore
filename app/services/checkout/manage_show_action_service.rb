class Checkout::ManageShowActionService
  attr_reader :order, :billing_address, :shipping_address, :deliveries, :credit_card, :delivery

  def initialize(order, user)
    @order = order
    @user = user
  end

  def call(step)
    public_send(step)
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
    @delivery = @order.delivery
    @credit_card = @order.credit_card.decorate
  end

  def complete
    @order = @user.orders.last.decorate
    @billing_address = @order.addresses.billing.first.decorate
  end
end

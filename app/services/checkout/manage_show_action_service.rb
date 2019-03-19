class Checkout::ManageShowActionService
  attr_reader :order, :billing_address, :shipping_address, :deliveries, :credit_card, :delivery

  def initialize(step, order)
    @step = step
    @order = order
    @user = @order.user
  end

  def call
    public_send(@step)
  end

  def addresses
    @billing_address = @order.addresses.billing.first_or_initialize
    @shipping_address = @order.addresses.shipping.first_or_initialize
  end

  def delivery
    @deliveries = Delivery.all
  end

  def payment
    @credit_card = @order.credit_card ? @order.credit_card : CreditCard.new
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

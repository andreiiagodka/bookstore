class Checkout::CheckStepCompletionService
  def initialize(order, user)
    @order = order
    @user = user
  end

  def call(step)
    public_send(step)
  end

  def addresses
    @order.user
  end

  def delivery
    @order.addresses.billing.exists? && @order.addresses.shipping.exists?
  end

  def payment
    @order.delivery
  end

  def confirm
    @order.credit_card
  end

  def complete
    @user.orders.last.completed?
  end
end

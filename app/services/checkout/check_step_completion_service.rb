class Checkout::CheckStepCompletionService
  def initialize(order, user)
    @order = order
    @user = user
  end

  def call(step)
    case step
    when CheckoutController::STEPS[:addresses] then addresses
    when CheckoutController::STEPS[:delivery] then delivery
    when CheckoutController::STEPS[:payment] then payment
    when CheckoutController::STEPS[:confirm] then confirm
    when CheckoutController::STEPS[:complete] then complete
    end
  end

  def addresses
    @order.user
  end

  def delivery
    !@order.addresses.billing.empty? && !@order.addresses.shipping.empty?
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

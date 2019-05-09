class CheckoutController < ApplicationController
  include Wicked::Wizard

  STEPS = {
    authentication: :authentication,
    addresses: :addresses,
    delivery: :delivery,
    payment: :payment,
    confirm: :confirm,
    complete: :complete
  }.freeze

  steps STEPS[:authentication], STEPS[:addresses], STEPS[:delivery], STEPS[:payment], STEPS[:confirm], STEPS[:complete]

  def show
    authentication_step? ? authentication : manage_show_action

    render_wizard
  end

  def update
    manage_update_action

    redirect_to next_wizard_path
  end

  private

  def authentication_step?
    step == STEPS[:authentication]
  end

  def authentication
    return false unless user_signed_in?

    current_order.update(user: current_user) unless current_order.user
    return jump_to(next_step)
  end

  def manage_show_action
    return jump_to(previous_step) unless Checkout::CheckStepCompletionService.new(current_order, current_user).call(step)

    @checkout = Checkout::ManageShowActionService.new(current_order, current_user)
    @checkout.call(step)
  end

  def manage_update_action
    Checkout::ManageUpdateActionService.new(current_order, params, session).call(step)
  end
end

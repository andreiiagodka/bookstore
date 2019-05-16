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
    manage_show_action

    render_wizard
  end

  def update
    manage_update_action

    redirect_to next_wizard_path
  end

  private

  def manage_show_action
    if user_signed_in?
      return jump_to(next_step) if authentication_step?

      return jump_to(previous_step) unless complete_step?
    end

    @checkout = Checkout::ManageShowActionService.new(current_order, current_user)
    @checkout.call(step)
  end

  def manage_update_action
    Checkout::ManageUpdateActionService.new(current_order, params, session).call(step)
  end

  def authentication_step?
    step == STEPS[:authentication]
  end

  def complete_step?
    Checkout::CheckStepCompletionService.new(current_order, current_user).call(step)
  end
end

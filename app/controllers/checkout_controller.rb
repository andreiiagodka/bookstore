class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :authentication, :addresses, :delivery, :payment, :confirm, :complete

  def show
    step == :authentication ? authentication : manage_show_action

    render_wizard
  end

  def update
    manage_update_action

    redirect_to next_wizard_path
  end

  private

  def authentication
    if user_signed_in?
      Orders::AttachUserService.new(current_order, current_user).call unless current_order.user
      return jump_to(next_step)
    end
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

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

  def manage_show_action
    initialize_checkout_instance.call
  end

  def manage_update_action
    Checkout::ManageUpdateActionService.new(step, current_order, params, session).call
  end

  def initialize_checkout_instance
    @checkout = Checkout::ManageShowActionService.new(step, current_order, current_user)
  end

  def authentication
    if user_signed_in?
      Orders::AttachUserService.new(current_order, current_user).call
      return jump_to(next_step)
    end
  end
end

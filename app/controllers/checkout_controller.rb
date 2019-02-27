class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :authentication, :addresses, :delivery, :payment, :confirm, :complete

  def show
    case step
    when :authentication then authentication
    when :addresses then addresses

    end
    render_wizard
  end

  private

  def authentication
    return jump_to(next_step) if user_signed_in?
  end

  def addresses

  end
end

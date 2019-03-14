class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :authentication, :addresses, :delivery, :payment, :confirm, :complete

  def show
    case step
    when :authentication then authentication
    when :addresses then addresses
    when :delivery then delivery
    end
    render_wizard
  end

  def update
    case step
    when :addresses then addresses_update

    end
    redirect_to next_wizard_path
  end

  private

  def authentication
    return jump_to(next_step) if user_signed_in?
  end

  def addresses
    return jump_to(next_step) if Addresses::CheckOrderAddressesService.new(current_order).call
  end

  def delivery

  end

  def addresses_update
    Addresses::ManageOrderAddressService.new(current_order, params).call
  end
end

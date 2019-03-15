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
    when :delivery then delivery_update
    end
    redirect_to next_wizard_path
  end

  private

  def authentication
    return jump_to(next_step) if user_signed_in?
  end

  def addresses
    return jump_to(next_step) if Addresses::CheckOrderAddressesExistenceService.new(current_order).call
  end

  def delivery
    return jump_to(next_step) if Addresses::CheckOrderDeliveriesExistenceService.new(current_order).call
  end

  def addresses_update
    Addresses::ManageOrderAddressService.new(current_order, order_params).call
  end

  def delivery_update
    Deliveries::ManageOrderDeliveriesService.new(current_order, order_params).call
  end

  def order_params
    params.require(:order)
  end
end

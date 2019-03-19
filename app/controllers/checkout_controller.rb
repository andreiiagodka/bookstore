class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :authentication, :addresses, :delivery, :payment, :confirm, :complete

  def show
    case step
    when :authentication then authentication
    when :addresses then addresses
    when :delivery then delivery
    when :payment then payment
    when :confirm then confirm
    when :complete then complete
    end
    render_wizard
  end

  def update
    case step
    when :addresses then addresses_update
    when :delivery then delivery_update
    when :payment then payment_update
    when :confirm then confirm_update
    end
    redirect_to next_wizard_path
  end

  private

  def authentication
    if user_signed_in?
      Orders::AttachUserService.new(current_order, current_user).call
      return jump_to(next_step)
    end
  end

  def addresses
    # return jump_to(next_step) if Addresses::CheckOrderAddressesExistenceService.new(current_order).call
  end

  def delivery
    # return jump_to(next_step) if Deliveries::CheckOrderDeliveryExistenceService.new(current_order).call
  end

  def payment

  end

  def confirm

  end

  def complete

  end

  def addresses_update
    Addresses::ManageOrderAddressService.new(current_order, order_params, params[:use_billing]).call
  end

  def delivery_update
    Deliveries::ManageOrderDeliveryService.new(current_order, order_params).call
  end

  def payment_update
    CreditCards::ManageOrderCreditCardService.new(current_order, order_params).call
  end

  def confirm_update
    Orders::CreateNumberService.new(current_order).call
    Orders::ClearCurrentOrderSessionService.new(session).call
  end

  def order_params
    params.require(:order)
  end
end

class Addresses::ManageOrderAddressService
  def initialize(order, params, use_billing)
    @order = order
    @params = params
    @use_billing = use_billing
    initialize_addresses
    initialize_addresses_params
  end

  def call
    manage_billing_address
    manage_shipping_address
  end

  private

  def initialize_addresses
    @billing = @order.addresses.billing
    @shipping = @order.addresses.shipping
  end

  def initialize_addresses_params
    @billing_params = address_params(:billing)
    @shipping_params = address_params(set_type)
  end

  def manage_billing_address
    @billing.exists? ? @billing.update(@billing_params) : @billing.create(@billing_params)
  end

  def manage_shipping_address
    @shipping.exists? ? @shipping.update(@shipping_params) : @shipping.create(@shipping_params)
  end

  def address_params(type)
    @params.require(type).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone)
  end

  def set_type
    @use_billing ? :billing : :shipping
  end
end

class Addresses::ManageOrderAddressService
  def initialize(order, params, use_billing)
    @order = order
    @params = params
    @use_billing = use_billing
  end

  def call
    manage_billing_address
    manage_shipping_address
  end

  private

  def manage_billing_address
    address = get_address(:billing)
    params = address_params(:billing)
    address.exists? ? address.update(params) : address.create(params)
  end

  def manage_shipping_address
    address = get_address(:shipping)
    params = address_params(set_type)
    address.exists? ? address.update(params) : address.create(params)
  end

  def get_address(cast)
    @order.addresses.public_send(cast)
  end

  def set_type
    @use_billing ? :billing : :shipping
  end

  def address_params(type)
    @params.require(type).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone)
  end
end

class Addresses::ManageOrderAddressService
  def initialize(order, params)
    @order = order
    @params = params
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
    @shipping_params = address_params(set_cast)
  end

  def manage_billing_address
    @billing.exists? ? @billing.update(@billing_params) : @billing.create(@billing_params)
  end

  def manage_shipping_address
    @shipping.exists? ? @shipping.update(@shipping_params) : @shipping.create(@shipping_params)
  end

  def address_params(cast)
    @params.require(:order).require(cast).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone)
  end

  def set_cast
    use_billing? ? :billing : :shipping
  end

  def use_billing?
    @params[:use_billing]
  end
end

class Addresses::CheckOrderAddressesService
  def initialize(order)
    @order = order
  end

  def call
    @order.addresses.billing.exists? && @order.addresses.shipping.exists?
  end
end

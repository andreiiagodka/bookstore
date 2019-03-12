class Addresses::CheckOrderAddressService
  def initialize(order)
    @order = order
  end

  def call
    Address.casts.keys.sort == @order.addresses.pluck(:cast).sort
  end
end

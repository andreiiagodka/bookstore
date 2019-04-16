class Addresses::ManageOrderAddressService
  def initialize(order, params, use_billing)
    @order = order
    @params = params
    @use_billing = use_billing
  end

  def call
    Address.casts.keys.each do |cast|
      address = get_address(cast.to_sym)
      params = address_params(set_type(cast.to_sym))
      address.exists? ? address.update(params) : address.create(params)
    end
  end

  private

  def get_address(cast)
    @order.addresses.public_send(cast)
  end

  def set_type(cast)
    case cast
    when :billing then :billing
    when :shipping then @use_billing ? :billing : :shipping
    end
  end

  def address_params(type)
    @params.fetch(type).slice(:first_name, :last_name, :country, :city, :address, :zip, :phone).to_enum.to_h
  end
end

class Addresses::ManageOrderAddressService
  CASTS = {
    billing: :billing,
    shipping: :shipping
  }.freeze

  def initialize(order, params, use_billing)
    @order = order
    @params = params
    @use_billing = use_billing
  end

  def call
    Address.casts.keys.each do |cast|
      params = address_params(define_type(cast.to_sym))
      AddressForm.new(params.merge(cast: cast)).save(@order)
    end
  end

  private

  def get_address(cast)
    @order.addresses.public_send(cast)
  end

  def define_type(cast)
    case cast
    when CASTS[:billing] then CASTS[:billing]
    when CASTS[:shipping] then @use_billing ? CASTS[:billing] : CASTS[:shipping]
    end
  end

  def address_params(type)
    @params.fetch(type).slice(:first_name, :last_name, :country, :city, :address, :zip, :phone).to_enum.to_h
  end
end

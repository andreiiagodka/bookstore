class AddressForm
  include ActiveModel::Model

  def initialize(object, params)
    @object = object
    @params = params
  end

  def save
    @object.addresses.public_send(address_params[:cast]).create(address_params)
  end

  private

  def address_params
    @params.require(:address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :cast)
  end
end

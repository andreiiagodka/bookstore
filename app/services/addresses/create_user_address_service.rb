class Addresses::CreateUserAddressService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.addresses.public_send(@params[:cast]).create(@params)
  end
end

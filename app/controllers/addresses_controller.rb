class AddressesController < ApplicationController
  load_and_authorize_resource

  def create
    if Addresses::CreateUserAddressService.new(current_user, address_params).call
      flash[:success] = t('message.success.address.create', type: address_params[:cast].capitalize)
      redirect_to @page_presenter.previous_url
    end
  end

  def update
    if @address.update(address_params)
      flash[:success] = t('message.success.address.update', type: address_params[:cast].capitalize)
      redirect_to @page_presenter.previous_url
    end
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :cast)
  end
end

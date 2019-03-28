class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :manage_address

  def create; end

  def update; end

  private

  def manage_address
    if AddressForm.new(address_params).save(current_user)
      flash[:success] = t('message.success.address.update', type: address_params[:cast].capitalize)
    else
      flash[:danger] = t('message.error.general')
    end
    redirect_to @page_presenter.previous_url
  end

  def address_params
    params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :cast)
  end
end

class AddressesController < ApplicationController
  load_and_authorize_resource

  before_action :manage_address

  def create; end

  def update; end

  private

  def manage_address
    address_form = AddressForm.new(address_params)
    if address_form.save(current_user)
      flash[:success] = t('message.success.address.update', type: address_params[:cast].capitalize)
    else
      flash[:danger] = address_form.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url and return
  end

  def address_params
    params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :cast)
  end
end

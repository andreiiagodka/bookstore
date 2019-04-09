require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { attributes_for(:address, cast: 'billing') }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'POST #create' do
    context 'valid attributes' do
      before do
        allow_any_instance_of(AddressForm).to receive(:save).with(user).and_return(true)
        post :create, xhr: true, params: { id: 1, address_form: params }
      end

      it do
        is_expected.to redirect_to root_path
        is_expected.to set_flash[:success].to I18n.t('message.success.address.update', type: params[:cast].capitalize)
      end
    end

    context 'invalid attributes' do
      let(:error) { I18n.t('message.error.address.text_field') }

      before do
        allow_any_instance_of(AddressForm).to receive(:save).with(user).and_return(false)
        allow_any_instance_of(AddressForm).to receive_message_chain(:errors, :full_messages, :to_sentence).and_return(error)
        post :create, xhr: true, params: { address_form: params }
      end

      it do
        is_expected.to redirect_to root_path
        is_expected.to set_flash[:danger].to error
      end
    end
  end
end

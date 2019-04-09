require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe 'POST create' do
    let(:address_params) do
      { address_form: attributes_for(:address, cast: 'billing') }
    end

    before { post :create, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT update' do
    let(:address) { create(:address, :billing, addressable: user) }
    let(:address_params) do
      { address_form: attributes_for(:address), id: address.id }
    end

    before { put :update, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end

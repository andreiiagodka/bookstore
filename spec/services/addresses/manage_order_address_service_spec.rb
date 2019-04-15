require 'rails_helper'

RSpec.describe Addresses::ManageOrderAddressService do
  subject(:manage_order_address_service) { described_class.new(order, params, use_billing) }

  describe 'create addresses' do
    let(:order) { create(:order) }

    context 'use_billing param is not present' do
      let(:params) do
        { billing: attributes_for(:address, :billing),
          shipping: attributes_for(:address, :shipping) }
      end
      let(:use_billing) { nil }

      it { expect { manage_order_address_service.call }.to change(order.addresses.billing, :count).by(1) }
      it { expect { manage_order_address_service.call }.to change(order.addresses.shipping, :count).by(1) }

      it do
        manage_order_address_service.call
        expect(order.addresses.billing.first.address).not_to eq order.addresses.shipping.first.address
      end
    end

    context 'use_billing param is present' do
      let(:params) do
        { billing: attributes_for(:address, :billing) }
      end
      let(:use_billing) { true }

      before { manage_order_address_service.call }

      it { expect(order.addresses.billing.first.address).to eq order.addresses.shipping.first.address }
    end
  end

  describe 'update addresses' do
    let(:order) { create(:order, :attach_addresses) }

    context 'use_billing param is not present' do
      let(:params) do
        { billing: attributes_for(:address, :billing),
          shipping: attributes_for(:address, :shipping) }
      end
      let(:use_billing) { nil }

      before { manage_order_address_service.call }

      it { expect(order.addresses.billing.first.address).to eq params[:billing][:address] }
      it { expect(order.addresses.shipping.first.address).to eq params[:shipping][:address] }
    end

    context 'use_billing param is present' do
      let(:params) do
        { billing: attributes_for(:address, :billing) }
      end
      let(:use_billing) { true }

      before { manage_order_address_service.call }

      it { expect(order.addresses.billing.first.address).to eq order.addresses.shipping.first.address }
    end
  end
end

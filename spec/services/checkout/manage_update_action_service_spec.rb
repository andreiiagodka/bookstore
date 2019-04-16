require 'rails_helper'

RSpec.describe Checkout::ManageUpdateActionService do
  subject(:manage_update_action_service) { described_class.new(order, params, session) }

  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:session) do
    { order_id: order.id }
  end

  describe 'addresses step' do
    let(:step) { :addresses }
    let(:params) do
      { order: {
        billing: attributes_for(:address, :billing),
          shipping: attributes_for(:address, :shipping),
          use_billing: false }
      }
    end

    it { expect(manage_update_action_service.call(step)).to eq Address.casts.keys }
  end

  describe 'delivery step' do
    let(:step) { :delivery }
    let(:delivery) { create(:delivery) }
    let(:params) do
      { order: { delivery_id: delivery.id } }
    end

    it { expect(manage_update_action_service.call(step)).to eq true }
  end

  describe 'payment step' do
    let(:step) { :payment }
    let(:params) do
      { order: { credit_card: attributes_for(:credit_card)  } }
    end

    it { expect(manage_update_action_service.call(step)).to eq true }
  end

  describe 'confirm step' do
    let(:step) { :confirm }
    let(:params) do
      { order: {} }
    end

    before { manage_update_action_service.call(step) }

    it do
      expect(order.status).to eq Order.statuses.keys.second
      expect(session[:order_id]).to eq nil
    end
  end
end

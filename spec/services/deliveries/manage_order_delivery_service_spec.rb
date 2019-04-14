require 'rails_helper'

RSpec.describe Deliveries::ManageOrderDeliveryService do
  subject(:manage_order_delivery_service) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:delivery) { create(:delivery) }
  let(:params) do
    { delivery_id: delivery.id }
  end

  it { expect(manage_order_delivery_service.call).to eq true }
end

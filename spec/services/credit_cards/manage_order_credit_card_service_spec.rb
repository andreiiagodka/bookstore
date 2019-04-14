require 'rails_helper'

RSpec.describe CreditCards::ManageOrderCreditCardService do
  let(:manage_order_credit_card_service) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:credit_card) { create(:credit_card) }
  let(:params) do
    { credit_card: attributes_for(:credit_card) }
  end

  it { expect(manage_order_credit_card_service.call).to eq true }
end

require 'rails_helper'

RSpec.describe Checkout::ManageShowActionService do
  subject(:manage_show_action_service) { described_class.new(order, user) }

  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:deliveries) { create_list(:delivery, 3) }

  describe 'addresses step' do
    let(:step) { :addresses }

    it { expect(manage_show_action_service.call(step)).to be_a AddressForm }
  end

  describe 'delivery step' do
    let(:step) { :delivery }

    it { expect(manage_show_action_service.call(step)).to match_array(deliveries) }
  end

  describe 'payment step' do
    let(:step) { :payment }

    it { expect(manage_show_action_service.call(step)).to be_a CreditCardForm }
  end

  describe 'confirm step' do
    let(:step) { :confirm }
    let(:credit_card) { create(:credit_card) }
    let(:delivery) { create(:delivery) }
    let(:order) { create(:order, :attach_addresses, delivery: delivery, credit_card: credit_card) }

    it { expect(manage_show_action_service.call(step)).to be_a CreditCard }
  end

  describe 'complete step' do
    let(:step) { :complete }
    let(:order) { create(:order, :attach_addresses, user: user) }

    it { expect(manage_show_action_service.call(step)).to be_a Address }
  end
end

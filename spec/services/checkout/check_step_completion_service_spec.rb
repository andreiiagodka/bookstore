require 'rails_helper'

RSpec.describe Checkout::CheckStepCompletionService do
  subject(:check_step_completion_service) { described_class.new(order, user) }

  let(:user) { create(:user) }

  describe 'addresses step' do
    let(:step) { :addresses }
    let(:order) { create(:order, user: user) }

    it { expect(check_step_completion_service.call(step)).to eq user }
  end

  describe 'delivery step' do
    let(:step) { :delivery }
    let(:order) { create(:order, :attach_addresses) }

    it { expect(check_step_completion_service.call(step)).to eq true }
  end

  describe 'payment step' do
    let(:step) { :payment }
    let(:delivery) { create(:delivery) }
    let(:order) { create(:order, delivery: delivery) }

    it { expect(check_step_completion_service.call(step)).to eq order.delivery }
  end

  describe 'confirm step' do
    let(:step) { :confirm }
    let(:credit_card) { create(:credit_card) }
    let(:order) { create(:order, credit_card: credit_card) }

    it { expect(check_step_completion_service.call(step)).to eq order.credit_card }
  end

  describe 'complete step' do
    let(:step) { :complete }
    let(:order) { create(:order) }
    let(:user) { create(:user, orders: [order]) }

    it do
      user.orders.last.complete
      expect(check_step_completion_service.call(step)).to eq true
    end
  end
end

require 'rails_helper'

RSpec.describe OrderBooks::UpdateQuantityService do
  subject(:update_quantity_service) { described_class.new(order_book, quantity_action) }

  let(:quantity_actions) { OrderBooks::UpdateQuantityService::QUANTITY_ACTION }

  context 'increment order book quantity' do
    let(:order_book) { create(:order_book) }
    let(:quantity_action) { quantity_actions[:increment] }

    it { expect { update_quantity_service.call }.to change(order_book, :quantity).by(1) }

    it do
      expect(order_book).to receive(:increment!).with(:quantity)
      update_quantity_service.call
    end
  end

  context 'decrement order book quantity' do
    let(:order_book) { create(:order_book, quantity: 2) }
    let(:quantity_action) { quantity_actions[:decrement] }

    it { expect { update_quantity_service.call }.to change(order_book, :quantity).by(-1) }

    it do
      expect(order_book).to receive(:decrement!).with(:quantity)
      update_quantity_service.call
    end
  end

  context 'decrement when quantity equals 1' do
    let(:order_book) { create(:order_book, quantity: 1) }
    let(:quantity_action) { quantity_actions[:decrement] }

    it { expect { update_quantity_service.call }.to change(order_book, :quantity).by(0) }
  end
end

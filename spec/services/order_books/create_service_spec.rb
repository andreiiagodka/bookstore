require 'rails_helper'

RSpec.describe OrderBooks::CreateService do
  subject(:create_service) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:order_book) { create(:order_book) }
  let(:random_number) { rand(10) }
  let(:params) { { book_id: order_book.book.id, quantity: random_number } }

  context 'when update book quantity' do
    before { allow(order).to receive_message_chain(:order_books, :find_by).and_return(order_book) }

    it { expect(create_service.call).to eq true }

    it 'receives update quantity' do
      expect(order_book).to receive(:update).with(quantity: (order_book.quantity + params[:quantity].to_i))
      create_service.call
    end

    it 'changes book quantity by given number' do
      expect { create_service.call }.to change(order_book, :quantity).by(random_number)
    end
  end

  context 'when create order book' do
    before { allow(order).to receive_message_chain(:order_books, :find_by).and_return(nil) }

    it do
      expect do
        expect(order).to receive_message_chain(:order_books, :create).with(params)
        create_service.call
      end.to change(OrderBook, :count).by(1)
    end
  end
end

require 'rails_helper'

RSpec.describe OrderBookDecorator do
  let(:order_book) { build_stubbed(:order_book).decorate }
  let(:subtotal_price) { order_book.book.price * order_book.quantity }

  it '#subtotal_price' do
    expect(order_book.subtotal_price).to eq subtotal_price
  end
end

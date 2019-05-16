require 'rails_helper'

RSpec.describe Orders::GetUserOrdersService do
  subject(:get_user_orders_service) { described_class.new(user, params) }

  let(:orders) { create_list(:order, 3) }
  let(:user) { create(:user, orders: orders) }
  let(:filter) { Filtering::ORDER_FILTERING_ORDER.keys.drop(1).sample }
  let(:params) { { filter: filter } }

  it { expect(get_user_orders_service.call).to eq user.orders.public_send(filter) }
end

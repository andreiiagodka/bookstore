require 'rails_helper'

RSpec.describe Orders::ClearCurrentOrderSessionService do
  subject(:clear_current_order_session_service) { described_class.new(session) }

  let(:order) { create(:order) }
  let(:session) do
    { order_id: order.id }
  end

  before { clear_current_order_session_service.call }

  it { expect(session[:order_id]).to eq nil }
end

require 'rails_helper'

RSpec.describe Orders::InitializeCurrentOrderSessionService do
  subject(:initialize_current_order_session_service) { described_class.new(user, session) }

  let(:user) { create(:user) }
  let(:session) { Hash.new }

  before { initialize_current_order_session_service.call }

  it { expect(session[:order_id]).not_to eq nil }
end

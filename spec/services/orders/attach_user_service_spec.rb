require 'rails_helper'

RSpec.describe Orders::AttachUserService do
  subject(:attach_user_service) { described_class.new(order, user) }

  let(:order) { create(:order) }
  let(:user) { create(:user) }

  before { attach_user_service.call }

  it { expect(order.user).to eq user }
end

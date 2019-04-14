require 'rails_helper'

RSpec.describe Coupons::DeactivateService do
  subject(:deactivate_service) { described_class.new(coupon) }

  let(:coupon) { create(:coupon) }

  it { expect { deactivate_service.call }.to change { coupon.active }.from(true).to(false) }
end

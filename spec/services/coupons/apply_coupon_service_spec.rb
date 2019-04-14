require 'rails_helper'

RSpec.describe Coupons::ApplyCouponService do
  let(:apply_coupon_service) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:params) do
    { code: coupon.code }
  end

  context 'when coupon is active' do
    let(:coupon) { create(:coupon) }

    before { apply_coupon_service.call }

    it { expect(order.coupon).to eq coupon }
  end

  context 'when coupon is inactive' do
    let(:coupon) { create(:coupon, active: false) }

    it { expect(apply_coupon_service.call).to eq false }
  end
end

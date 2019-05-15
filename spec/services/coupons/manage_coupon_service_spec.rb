require 'rails_helper'

RSpec.describe Coupons::ManageCouponService do
  let(:manage_coupon_service) { described_class.new(order, params) }

  let(:order) { create(:order) }
  let(:params) do
    { code: coupon.code }
  end

  context 'when coupon is active' do
    let(:coupon) { create(:coupon) }

    before { manage_coupon_service.apply }

    it do
      expect(order.coupon).to eq coupon
    end
  end

  context 'when coupon is inactive' do
    let(:coupon) { create(:coupon, active: false) }

    it { expect(manage_coupon_service.apply).to eq nil }
  end
end

require 'rails_helper'

RSpec.describe Coupons::GetActiveCouponByCodeService do
  subject(:get_active_coupon_by_code_service) { described_class.new(params) }

  let(:coupon) { create(:coupon) }
  let(:params) do
    { code: coupon.code }
  end

  it { expect(get_active_coupon_by_code_service.call).to eq coupon }
end

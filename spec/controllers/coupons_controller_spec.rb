require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let(:order) { create(:order) }

  before { allow(controller).to receive(:current_order).and_return(order) }

  describe 'PUT update' do
    let(:coupon) { create(:coupon) }
    let(:coupon_params) do
      { coupon: { code: coupon.code }, id: coupon.id }
    end

    before { put :update, params: coupon_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end

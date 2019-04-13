require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:steps) { CheckoutController::STEPS }

  before { sign_in(user) }

  before { allow(controller).to receive(:current_user).and_return(user) }
  before { allow(controller).to receive(:current_order).and_return(order) }

  describe 'GET show' do
    CheckoutController::STEPS.values.each do |step|
      before { get :show, params: { id: step } }

      it "redirects from #{step}" do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST update' do
    context 'addresses step' do
      let(:address_form_params) do
        { billing: attributes_for(:address, cast: 'billing'),
          shipping: attributes_for(:address, cast: 'shipping') }
        end

        it 'returns a redirect response' do
          put :update, params: { id: :addresses, order: address_form_params }
          expect(response).to have_http_status(302)
        end
      end

      context 'delivery step' do
        let(:delivery) { create(:delivery) }

        it 'returns a redirect response' do
          put :update, params: { id: :delivery, order: { delivery_id: delivery.id } }
          expect(response).to have_http_status(302)
        end
      end

      context 'payment step' do
        let(:credit_card_form_params) do
          { credit_card: attributes_for(:credit_card) }
        end

        it 'returns a redirect response' do
          put :update, params: { id: :payment, order: credit_card_form_params }
          expect(response).to have_http_status(302)
        end
      end

      context 'confirm step' do
        it 'return a redirect response' do
          put :update, params: { id: :confirm }
          expect(response).to have_http_status(302)
        end
      end
    end
  end

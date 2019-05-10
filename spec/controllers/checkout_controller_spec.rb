require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }

  before { allow(controller).to receive(:current_order).and_return(order) }

  describe 'GET show' do
    let(:order) { create(:order, :attach_addresses, delivery: delivery, credit_card: credit_card, user: user) }
    let(:delivery) { create(:delivery) }
    let(:credit_card) { create(:credit_card) }

    context 'response with 200' do
      CheckoutController::STEPS.values.each do |step|
        if step == :complete
          it "#{step}" do
            allow(controller).to receive(:current_user).and_return(user)
            order.complete!

            get :show, params: { id: step }
            expect(subject).to respond_with(200)
            expect(subject).to render_template step.to_s
          end
        else
          it "#{step}" do
            get :show, params: { id: step }
            expect(subject).to respond_with(200)
            expect(subject).to render_template step.to_s
          end
        end
      end
    end

    context 'response with 302' do
      CheckoutController::STEPS.values.each do |step|
        before do
          allow(controller).to receive(:current_user).and_return(user)
          get :show, params: { id: step }
        end

        it "#{step}" do
          expect(subject).to respond_with(302)
        end
      end
    end
  end

  describe 'PUT update' do
    let(:order) { create(:order, user: user) }

    context 'addresses step' do
      let(:address_form_params) do
        { billing: attributes_for(:address),
          shipping: attributes_for(:address, cast: 'shipping') }
        end

        it do
          put :update, params: { id: CheckoutController::STEPS[:addresses], order: address_form_params }
          expect(order.addresses).not_to eq nil
        end
      end

      context 'delivery step' do
        let(:delivery) { create(:delivery) }

        it do
          put :update, params: { id: CheckoutController::STEPS[:delivery], order: { delivery_id: delivery.id } }
          expect(order.delivery).to eq delivery
        end
      end

      context 'payment step' do
        let(:credit_card_form_params) do
          { credit_card: attributes_for(:credit_card) }
        end

        it do
          put :update, params: { id: CheckoutController::STEPS[:payment], order: credit_card_form_params }
          expect(order.credit_card).not_to eq nil
        end
      end

      context 'confirm step' do
        it do
          put :update, params: { id: CheckoutController::STEPS[:confirm] }
          expect(order.completed?).to eq true
        end
      end
    end
  end

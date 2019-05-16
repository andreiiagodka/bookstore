require 'rails_helper'

RSpec.describe OrderBooksController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order) }
  let(:order_book) { create(:order_book) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_order).and_return(order)
  end

  describe 'POST create' do
    let(:params) { { order_book: attributes_for(:order_book) } }

    before { post :create, params: params }

    it 'assigns @order_book' do
      expect(assigns(:order_book)).to be_a OrderBook
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT update' do
    let(:params) do
      { id: order_book.id, order_book: attributes_for(:order_book) }
    end

    before { put :update, params: params }

    it 'assigns @order_book' do
      expect(assigns(:order_book)).to be_a OrderBook
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE destroy' do
    let(:params) do
      { id: order_book.id, order_book: attributes_for(:order_book) }
    end

    before { delete :destroy, params: params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end

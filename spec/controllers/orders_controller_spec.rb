require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before { sign_in(user) }

  describe 'GET index' do
    let(:filter_param) { Filtering::BOOK_FILTERING_ORDER.keys[0].to_s }

    before { get :index, params: { filter: filter_param } }

    it 'assigns @filtering_param' do
      expect(assigns(:filtering_param)).to eq(filter_param)
    end

    it 'returns success response' do
      expect(response).to have_http_status(200)
    end

    it 'renders template :index' do
      expect(subject).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order.id } }

    it 'assigns @order' do
      expect(assigns(:order)).to match(order)
    end

    it 'returns success response' do
      expect(response).to have_http_status(200)
    end

    it 'renders template :show' do
      expect(subject).to render_template(:show)
    end
  end
end

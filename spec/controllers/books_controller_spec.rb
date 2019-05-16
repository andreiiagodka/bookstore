require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET index' do
    before { get :index }

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book.id } }

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns @book' do
      expect(assigns(:book)).to eq book
    end
  end
end

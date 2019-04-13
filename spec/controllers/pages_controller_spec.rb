require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:books) { create_list(:book, 5) }

  describe 'GET home' do
    before { get :home }

    it 'assigns @latest_books' do
      expect(assigns(:latest_books)).to match_array(books.last(PagesController::LATEST_BOOKS_QUANTITY))
    end

    it 'returns success response' do
      expect(response).to have_http_status(200)
    end
  end
end

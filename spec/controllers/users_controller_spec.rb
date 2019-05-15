require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'PUT update' do
    context 'when update email' do
      let(:email_params) do
        { id: user.id, user: { email: user.email } }
      end

      before { put :update, params: email_params }

      it 'returns redirect response' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when update password' do
      let(:new_password) { '123123' }
      let(:password_params) do
        { id: user.id, user: { current_password: user.password, password: new_password, password_confirmation: new_password } }
      end

      before { put :update, params: password_params }

      it 'return redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:params) do
      { id: user.id, user: attributes_for(:user) }
    end

    before { delete :destroy, params: params }

    it 'returns redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end

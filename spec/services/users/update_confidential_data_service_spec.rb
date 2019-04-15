require 'rails_helper'

RSpec.describe Users::UpdateConfidentialDataService do
  subject(:update_confidential_data_service) { described_class.new(user, params) }

  let(:user) { create(:user) }

  context 'update email' do
    let(:params) do
      { email: user.email }
    end

    it do
      expect(user).to receive(:update).with(params)
      update_confidential_data_service.call
    end
  end

  context 'update password' do
    let(:params) do
      { current_password: user.password, password: '123123', password_confirmation: '123123' }
    end

    it do
      expect(user).to receive(:update_with_password).with(params)
      update_confidential_data_service.call
    end
  end
end

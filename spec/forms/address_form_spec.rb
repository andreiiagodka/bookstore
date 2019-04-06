require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:first_name).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:country).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:city).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:address).is_at_most(AddressForm::LENGTH[:text]) }
    it { is_expected.to validate_length_of(:zip).is_at_most(AddressForm::LENGTH[:zip]) }
    it { is_expected.to validate_length_of(:phone).is_at_most(AddressForm::LENGTH[:phone]) }
  end

  describe 'valid inputs' do
    let(:valid_text_input) { 'test' }
    let(:valid_zip_input) { '49000' }
    let(:valid_phone_input) { '+3809711111111' }

    it { is_expected.to allow_value(valid_text_input).for(:first_name) }
    it { is_expected.to allow_value(valid_text_input).for(:last_name) }
    it { is_expected.to allow_value(valid_text_input).for(:country) }
    it { is_expected.to allow_value(valid_text_input).for(:city) }
    it { is_expected.to allow_value(valid_text_input).for(:address) }
    it { is_expected.to allow_value(valid_zip_input).for(:zip) }
    it { is_expected.to allow_value(valid_phone_input).for(:phone) }
  end

  describe 'invalid inputs' do
    let(:invalid_text_input) { '123' }
    let(:invalid_address_input) { '' }
    let(:invalid_zip_input) { 'qwerty' }
    let(:invalid_phone_input) { 'qwerty' }

    it { is_expected.not_to allow_value(invalid_text_input).for(:first_name) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:last_name) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:country) }
    it { is_expected.not_to allow_value(invalid_text_input).for(:city) }
    it { is_expected.not_to allow_value(invalid_address_input).for(:address) }
    it { is_expected.not_to allow_value(invalid_zip_input).for(:zip) }
    it { is_expected.not_to allow_value(invalid_phone_input).for(:phone) }
  end

  describe '#save' do
    subject(:address_form) { described_class.new(params) }

    let(:params) { attributes_for(:address, :billing) }
    let(:order) { create(:order) }

    it 'success' do
      address_form.save(order)
      expect(order.addresses.billing.first.first_name).to eq params[:first_name]
    end

    it 'fail' do
      allow(address_form).to receive(:valid?).and_return(false)
      address_form.save(order)
      expect(order.addresses.billing.first).to eq nil
    end
  end
end

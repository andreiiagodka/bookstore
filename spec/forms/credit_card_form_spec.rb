require 'rails_helper'

RSpec.describe CreditCardForm, type: :model do
  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:expire_date) }
    it { is_expected.to validate_presence_of(:cvv) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:number).is_equal_to(CreditCardForm::LENGTH[:number]) }
    it { is_expected.to validate_length_of(:name).is_at_most(CreditCardForm::LENGTH[:name]) }
    it { is_expected.to validate_length_of(:cvv).is_at_least(CreditCardForm::CVV_RANGE.min).is_at_most(CreditCardForm::CVV_RANGE.max) }
  end

  describe 'numericality validations' do
    it { is_expected.to validate_numericality_of(:number).only_integer }
    it { is_expected.to validate_numericality_of(:cvv) }
  end

  describe 'valid inputs' do
    let(:valid_number_input) { '1111222233334444' }
    let(:valid_name_input) { 'Andrei Iagodka' }
    let(:valid_expire_date_input) { '12/12' }
    let(:valid_cvv_input) { '111' }

    it { is_expected.to allow_value(valid_number_input).for(:number) }
    it { is_expected.to allow_value(valid_name_input).for(:name) }
    it { is_expected.to allow_value(valid_expire_date_input).for(:expire_date) }
    it { is_expected.to allow_value(valid_cvv_input).for(:cvv) }
  end

  describe 'valid inputs' do
    let(:invalid_number_input) { 'qwerty' }
    let(:invalid_name_input) { '12345' }
    let(:invalid_expire_date_input) { 'qwerty' }
    let(:invalid_cvv_input) { 'qwerty' }

    it { is_expected.not_to allow_value(invalid_number_input).for(:number) }
    it { is_expected.not_to allow_value(invalid_name_input).for(:name) }
    it { is_expected.not_to allow_value(invalid_expire_date_input).for(:expire_date) }
    it { is_expected.not_to allow_value(invalid_cvv_input).for(:cvv) }
  end

  describe '#save' do
    subject(:credit_card_form) { described_class.new(params) }

    let(:params) { attributes_for(:credit_card) }
    let(:order) { create(:order) }

    it 'success' do
      credit_card_form.save(order)
      expect(order.credit_card.number).to eq params[:number]
    end

    it 'fail' do
      allow(credit_card_form).to receive(:valid?).and_return(false)
      credit_card_form.save(order)
      expect(order.credit_card).to eq nil
    end
  end
end

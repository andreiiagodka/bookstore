require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:number).of_type(:string) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:delivery_id).of_type(:integer) }
    it { is_expected.to have_db_column(:credit_card_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:delivery_id) }
    it { is_expected.to have_db_index(:credit_card_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).without_validating_presence }
    it { is_expected.to belong_to(:delivery).without_validating_presence }
    it { is_expected.to belong_to(:credit_card).without_validating_presence }
    it { is_expected.to have_one(:coupon).dependent(:destroy) }
    it { is_expected.to have_many(:order_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:order_books) }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
  end

  describe 'scopes' do
    it 'orders by created_at desc' do
      expect(Order.created_at_desc).to eq Order.order('created_at desc')
    end
  end

  describe 'status enum value' do
    it { expect(Order.statuses[:in_progress]).to eq 0 }
    it { expect(Order.statuses[:completed]).to eq 1 }
    it { expect(Order.statuses[:in_delivery]).to eq 2 }
    it { expect(Order.statuses[:delivered]).to eq 3 }
    it { expect(Order.statuses[:canceled]).to eq 4 }
  end
end

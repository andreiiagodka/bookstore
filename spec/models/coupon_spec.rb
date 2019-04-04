require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:code).of_type(:string) }
    it { is_expected.to have_db_column(:discount_percent).of_type(:integer).with_options(default: 10) }
    it { is_expected.to have_db_column(:active).of_type(:boolean).with_options(default: true) }
    it { is_expected.to have_db_column(:order_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:order_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:order).without_validating_presence }
  end

  describe 'scopes' do
    it 'active' do
      expect(Coupon.active).to eq Coupon.where(active: true)
    end

    it 'inactive' do
      expect(Coupon.inactive).to eq Coupon.where(active: false)
    end
  end
end

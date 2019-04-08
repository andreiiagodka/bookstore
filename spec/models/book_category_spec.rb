require 'rails_helper'

RSpec.describe BookCategory, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:category_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:category_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:category) }
  end
end

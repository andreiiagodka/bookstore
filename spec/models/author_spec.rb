require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:book_authors).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:book_authors) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

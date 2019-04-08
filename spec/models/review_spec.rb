require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:score).of_type(:integer) }
    it { is_expected.to have_db_column(:published).of_type(:boolean) }
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'scopes' do
    it 'published' do
      expect(Review.published).to eq Review.where(published: true)
    end

    it 'unpublished' do
      expect(Review.unpublished).to eq Review.where(published: false)
    end
  end
end

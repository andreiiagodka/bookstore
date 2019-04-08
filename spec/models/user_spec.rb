require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'database columns' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:unconfirmed_email).of_type(:string) }
    it { is_expected.to have_db_column(:failed_attempts).of_type(:integer).with_options(default: 0, null: false) }
    it { is_expected.to have_db_column(:unlock_token).of_type(:string) }
    it { is_expected.to have_db_column(:locked_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:provider).of_type(:string) }
    it { is_expected.to have_db_column(:uid).of_type(:string) }
    it { is_expected.to have_db_index(:email).unique }
    it { is_expected.to have_db_index(:reset_password_token).unique }
  end

  describe 'assosiations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
  end
end

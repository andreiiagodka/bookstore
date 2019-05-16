require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'when user is persisted' do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to :create, Review, user_id: user.id }
    it { is_expected.to be_able_to [:show, :update, :destroy], User, id: user.id }
    it { is_expected.to be_able_to [:create, :update], Address, addressable_id: user.id, addressable_type: 'User' }
    it { is_expected.to be_able_to :index, Order }
  end

  describe 'when user is not logged in' do
    let(:user) { build(:user) }

    it { is_expected.to be_able_to :read, Review }
    it { is_expected.to be_able_to :show, Order }
    it { is_expected.to be_able_to [:index, :show], Book }
    it { is_expected.to be_able_to [:create, :update, :destroy], OrderBook }
  end
end

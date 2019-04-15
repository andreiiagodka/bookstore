require 'rails_helper'

RSpec.describe Books::FilteringService do
  subject(:filtering_service) { described_class.new(filter) }

  context 'filter is passed' do
    let(:filter) { Filtering::BOOK_FILTERING_ORDER.keys.drop(1).sample }

    it { expect(filtering_service.call).to eq filter }
  end

  context 'filter is not passed' do
    let(:filter) { nil }
    let(:default_filter) { Filtering::DEFAULT_BOOK_FILTERING_ORDER }

    it { expect(filtering_service.call).to eq default_filter }
  end
end

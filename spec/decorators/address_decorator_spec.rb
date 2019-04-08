require 'rails_helper'

RSpec.describe AddressDecorator do
  describe '#full_name' do
    let(:address) { build_stubbed(:address, :billing).decorate }
    let(:full_name) { "#{address.first_name} #{address.last_name}" }

    it { expect(address.full_name).to eq full_name }
  end
end

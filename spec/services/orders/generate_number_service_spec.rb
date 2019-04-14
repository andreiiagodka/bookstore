require 'rails_helper'

RSpec.describe Orders::GenerateNumberService do
  subject(:generate_number_service) { described_class.new }

  let(:number_prefix) { Orders::GenerateNumberService::NUMBER_PREFIX }
  let(:date_format) { Orders::GenerateNumberService::DATE_FORMAT }
  let(:number) { number_prefix + Time.now.strftime(date_format) }

  it { expect(generate_number_service.call).to eq number }
end

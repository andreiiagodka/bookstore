require 'rails_helper'

RSpec.describe CreditCardDecorator do
  let(:credit_card) { build_stubbed(:credit_card).decorate }
  let(:masked_part) { '**** **** ****' }
  let(:visible_chars_quantity) { CreditCardDecorator::GROUPED_CHARS_QUANTITY }

  it '#masked_number' do
    expect(credit_card.masked_number).to eq "#{masked_part} #{credit_card.number.last(visible_chars_quantity)}"
  end
end

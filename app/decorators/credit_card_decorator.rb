class CreditCardDecorator < Draper::Decorator
  delegate_all

  GROUPED_CHARS_QUANTITY = 4
  MASKING_CHAR = '*'.freeze

  def masked_number
    masked_part + ' ' + number.last(GROUPED_CHARS_QUANTITY)
  end

  private

  def masked_part
    (MASKING_CHAR * masked_chars_quantity).scan(MASKING_CHAR * GROUPED_CHARS_QUANTITY).join(' ')
  end

  def masked_chars_quantity
    CreditCardForm::LENGTH[:number] - GROUPED_CHARS_QUANTITY
  end
end

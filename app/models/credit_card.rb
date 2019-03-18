class CreditCard < ApplicationRecord
  has_one :order, dependent: :destroy

  FORMATS = {
    name: /\A^[a-zA-Z\s]+$\z/,
    expire_date: /\A^(0[1-9]|1[0-2])\/?([0-9]{2})$\z/
  }.freeze

  CVV_RANGE = (3..4).freeze

  validates :number, :name, :expire_date, :cvv, presence: true

  validates :number,
            length: { is: 16 },
            numericality: { only_integer: true }

  validates :name,
            length: { maximum: 50 },
            format: { with: FORMATS[:name], message: I18n.t('message.error.credit_card.name_field') }

  validates :expire_date,
            format: { with: FORMATS[:expire_date], message: I18n.t('message.error.credit_card.expire_date_field') }

  validates :cvv,
            length: { in: CVV_RANGE },
            numericality: { only_integer: true }
end

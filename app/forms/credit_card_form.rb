class CreditCardForm
  include ActiveModel::Model
  include Virtus.model

  FORMATS = {
    name: /\A^[a-zA-Z\s]+$\z/,
    expire_date: /\A^(0[1-9]|1[0-2])\/?([0-9]{2})$\z/
  }.freeze

  LENGTH = {
    number: 16,
    name: 50
  }.freeze

  CVV_RANGE = (3..4).freeze

  attribute :number, String
  attribute :name, String
  attribute :expire_date, String
  attribute :cvv, Integer

  validates :number, :name, :expire_date, :cvv, presence: true

  validates :number,
            length: { is: LENGTH[:number] },
            numericality: { only_integer: true }

  validates :name,
            length: { maximum: LENGTH[:name] },
            format: { with: FORMATS[:name], message: I18n.t('message.error.credit_card.name_field') }

  validates :expire_date,
            format: { with: FORMATS[:expire_date], message: I18n.t('message.error.credit_card.expire_date_field') }

  validates :cvv,
            length: { in: CVV_RANGE },
            numericality: { only_integer: true }

  def save(object)
    return false unless valid?

    credit_card = object.credit_card
    credit_card ? credit_card.update(params) : object.update(credit_card: new_credit_card)
  end

  private

  def new_credit_card
    CreditCard.create(params)
  end

  def params
    {
      number: number,
      name: name,
      expire_date: expire_date,
      cvv: cvv
    }
  end
end 

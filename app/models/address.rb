class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  FORMATS = {
    text: /\A[a-zA-Z]*\z/,
    address: /\A[a-zA-Z0-9 \-\,]*\z/,
    zip: /\A[0-9\-]*\z/,
    phone: /\A\+[0-9]*\z/
  }.freeze

  validates :first_name, :last_name, :country, :city, :address, :zip, :phone, :cast, presence: true

  validates :first_name, :last_name, :country, :city,
            format: { with: FORMATS[:text],
                      message: I18n.t('message.error.address.text_field') },
            length: { maximum: 50 }

  validates :address,
            format: { with: FORMATS[:address],
                      message: I18n.t('message.error.address.address_field') },
            length: { maximum: 50 }

  validates :zip,
            format: { with: FORMATS[:zip],
                      message: I18n.t('message.error.address.zip_field') },
            length: { maximum: 10 }

  validates :phone,
            format: { with: FORMATS[:phone],
                      message: I18n.t('message.error.address.phone_field') },
            length: { maximum: 15 }

  enum cast: {
    billing: 0,
    shipping: 1
  }
end

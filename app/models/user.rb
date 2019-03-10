class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_addresses, dependent: :destroy
  has_many :addresses, through: :user_addresses

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
   end
  end
end

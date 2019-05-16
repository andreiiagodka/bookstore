require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe '#completed_order' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user) }
    let(:email_from) { 'from@example.com' }
    let(:mail) { OrderMailer.completed_order(order) }

    it 'renders headers' do
      expect(mail.from).to eq [email_from]
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq I18n.t('mailer.order.subject')
    end
  end
end

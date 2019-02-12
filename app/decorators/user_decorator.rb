class UserDecorator < Draper::Decorator
  delegate_all

  def email_capital_letter
    email.first.capitalize
  end
end

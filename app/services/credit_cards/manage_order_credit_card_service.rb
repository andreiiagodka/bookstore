class CreditCards::ManageOrderCreditCardService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    CreditCardForm.new(credit_card_params).save(@order)
  end

  private

  def credit_card_params
    @params.fetch(:credit_card).slice(:number, :name, :expire_date, :cvv).to_enum.to_h
  end
end

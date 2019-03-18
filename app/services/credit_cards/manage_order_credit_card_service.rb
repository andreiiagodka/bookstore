class CreditCards::ManageOrderCreditCardService
  def initialize(order, params)
    @order = order
    @params = params
    @credit_card = @order.credit_card
  end

  def call
    @credit_card ? @credit_card.update(credit_card_params) : @order.update(credit_card: new_credit_card)
  end

  private

  def new_credit_card
    CreditCard.create(credit_card_params)
  end

  def credit_card_params
    @params.require(:credit_card).permit(:number, :name, :expire_date, :cvv)
  end
end

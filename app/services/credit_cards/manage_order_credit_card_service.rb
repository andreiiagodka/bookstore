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
    @params.require(:credit_card).permit(:number, :name, :expire_date, :cvv)
  end
end

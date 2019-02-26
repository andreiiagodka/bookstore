class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :login

  def show
    case step
    when :login then login

    end
    render_wizard
  end

  def login

  end
end

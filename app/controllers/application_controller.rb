class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  before_action :initialize_category_presenter

  private

  def initialize_category_presenter
    @category_presenter = CategoryPresenter.new(categories: Category.all).attach_controller(self)
  end
end

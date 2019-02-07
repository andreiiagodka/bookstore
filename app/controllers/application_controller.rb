class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  before_action :create_categories_dropdown

  private

  def create_categories_dropdown
    present CategoriesDropdownPresenter.new(categories: Category.all)
  end
end

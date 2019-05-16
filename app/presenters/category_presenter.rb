class CategoryPresenter < Rectify::Presenter
  def all_categories
    @all_categories ||= Category.all
  end
end

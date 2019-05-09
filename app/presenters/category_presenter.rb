class CategoryPresenter < Rectify::Presenter
  def get_all_categories
    @get_all_categories ||= Category.all
  end
end

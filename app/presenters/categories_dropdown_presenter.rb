class CategoriesDropdownPresenter < Rectify::Presenter
  attribute :categories, Category

  def categories_dropdown_list(css_class: '')
    categories.map { |category| build_categories_list(category, css_class) }.join.html_safe
  end

  private

  def build_categories_list(category, css_class)
    content_tag(:li) do
      link_to category.name, categories_path(id: category), class: css_class
    end
  end
end

class CategoryPresenter < Rectify::Presenter
  attribute :categories, Category

  def list(css_class: '')
    categories.map do |category|
      content_tag(:li) do
        link_to category.name, categories_path(id: category), class: css_class
      end
    end.join.html_safe
  end

  def list_with_counters
    categories.map do |category|
      content_tag(:li, class: 'mr-35') do
        link_to(
          (category.name + content_tag(:span, category.books.count, class: 'badge general-badge')).html_safe,
          categories_path(id: category),
          class: 'filter-link'
        )
      end
    end.join.html_safe
  end
end

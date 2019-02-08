class BookPresenter < Rectify::Presenter
  attribute :books, Book

  def all_with_counter
    content_tag(:li, class: 'mr-35') do
      link_to(
        (t('catalog.all') + content_tag(:span, books.count, class: 'badge general-badge')).html_safe,
        books_path,
        class: 'filter-link'
      )
    end
  end
end

ActiveAdmin.register Book do
  decorate_with BookDecorator

  permit_params :name, :price, :description, :publication_year, :height, :width, :depth, :material,
                category_ids: [], authors_ids: []

  includes :categories, :authors

  config.filters = false

  index do
    render 'admin/books/index', context: self
  end

  form partial: 'form'
end

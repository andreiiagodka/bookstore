ActiveAdmin.register Book do
  decorate_with BookDecorator

  permit_params :name, :price, :description, :publication_year, :height, :width, :depth, :material,
                category_ids: [], authors_ids: []

  includes :categories, :authors

  config.filters = false

  index do
    selectable_column
    column :cover do |book|
      book.cover_image(:cart)
    end
    column :categories do |book|
      book.categories_as_string
    end
    column :name
    column :authors do |book|
      book.authors_as_string
    end
    column :description do |book|
      book.short_description
    end
    column :price do |book|
      t('price', price: book.price)
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :description, as: :simplemde_editor
      f.input :price
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :material
      f.input :categories, as: :check_boxes, collection: Category.all.map { |category| [category.name, category.id] }
      f.input :authors, as: :check_boxes, collection: Author.all.map { |author| [author.name, author.id] }
      f.actions
    end
  end
end

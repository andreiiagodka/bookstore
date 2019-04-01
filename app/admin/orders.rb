ActiveAdmin.register Order do
  decorate_with OrderDecorator

  permit_params :status

  config.filters = false

  scope :in_progress
  scope :completed
  scope :in_delivery
  scope :delivered
  scope :canceled


  index do
    selectable_column
    column :number
    column t('admin.order.date_of_creation') do |order|
      order.creation_date
    end
    column t('admin.order.state') do |order|
      order.status_title
    end
    actions defaults: false do |order|
      link_to t('admin.order.change_state'), edit_admin_order_path(order)
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :status, as: :select, collection: Order.statuses.keys.drop(2).map { |status|
        [status.capitalize.tr('_', ' '), status]
      }
      f.actions
    end
  end
end

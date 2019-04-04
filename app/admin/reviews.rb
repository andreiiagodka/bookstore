ActiveAdmin.register Review do

  actions :index, :show

  scope :published
  scope :unpublished

  config.filters = false

  index do
    selectable_column
    column :book
    column :title
    column t('admin.review.date'), :created_at
    column :user
    column :published
    actions
  end

  action_item :publish, only: :show do
    link_to t('admin.review.publish'), publish_admin_review_path(review), method: :put unless review.published
  end

  action_item :publish, only: :show do
    link_to t('admin.review.unpublish'), unpublish_admin_review_path(review), method: :put if review.published
  end

  member_action :publish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(published: true)
    redirect_to admin_review_path(review)
  end

  member_action :unpublish, method: :put do
    review = Review.find_by(id: params[:id])
    review.update(published: false)
    redirect_to admin_review_path(review)
  end
end

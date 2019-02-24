class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    if @review.save
      flash[:success] = t('message.success.review.create')
    else
      flash[:danger] = review.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :score, :book_id, :user_id)
  end
end

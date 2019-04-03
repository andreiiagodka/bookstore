class ReviewsController < ApplicationController
  authorize_resource

  def create
    review = ReviewForm.new(review_params)
    if review.save
      flash[:success] = t('message.success.review.create')
    else
      flash[:danger] = review.errors.full_messages.to_sentence
    end

    redirect_to @page_presenter.previous_url
  end

  private

  def review_params
    params.require(:review_form).permit(:title, :body, :score, :book_id, :user_id)
  end
end

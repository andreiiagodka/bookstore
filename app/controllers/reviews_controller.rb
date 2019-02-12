class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    review.save ? flash[:success] = t('review.success_msg') : flash[:danger] = review.errors.full_messages.to_sentence
    redirect_to @page_presenter.previous_url
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :score, :book_id, :user_id)
  end
end

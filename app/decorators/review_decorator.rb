class ReviewDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def slash_date_format
    created_at.strftime('%m/%d/%Y')
  end
end

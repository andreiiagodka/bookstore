require 'rails_helper'

RSpec.describe Admin::ReviewsController, type: :controller do
  describe "not admin user is not allowed to access admin panel" do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'reviews actions' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:review) { create(:review) }

    render_views
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the review' do
        expect(assigns(:reviews)).to include review
      end

      it 'should render the expected columns' do
        expect(page).to have_content review.book.name
        expect(page).to have_content review.title
        expect(page).to have_content I18n.t('admin.review.date')
        expect(page).to have_content review.user.email
        expect(page).to have_content I18n.t('admin.review.published')
      end
    end

    describe 'GET show' do
      before do
        get :show, params: { id: review.id }
      end

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the review' do
        expect(assigns(:review)).to eq review
      end

      it 'should render the form elements' do
        expect(page).to have_content review.title
        expect(page).to have_content review.body
        expect(page).to have_content review.score
        expect(page).to have_content I18n.t('admin.review.published')
        expect(page).to have_content review.user.email
        expect(page).to have_content review.book.name
      end
    end

    describe 'PUT publish' do
      before do
        put :publish, params: { id: review.id }
      end

      it 'responds with 302' do
        is_expected.to respond_with 302
        expect(response).to redirect_to(admin_review_path(review))
      end

      it 'should publish the review' do
        review.reload
        expect(review.published).to eq true
      end
    end

    describe 'PUT unpublish' do
      before do
        put :unpublish, params: { id: review.id }
      end

      it 'responds with 302' do
        is_expected.to respond_with 302
        expect(response).to redirect_to(admin_review_path(review))
      end

      it 'should unpublish the review' do
        review.reload
        expect(review.published).to eq false
      end
    end
  end
end

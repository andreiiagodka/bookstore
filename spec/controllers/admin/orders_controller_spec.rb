require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe "not admin user is not allowed to access admin panel" do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'order actions' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:order) { create(:order, :attach_book).decorate }

    render_views
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the author' do
        expect(assigns(:orders)).to include order
      end

      it 'should render the expected columns' do
        expect(page).to have_content order.number
        expect(page).to have_content I18n.t('admin.order.date_of_creation')
        expect(page).to have_content I18n.t('admin.order.state')
        expect(page).to have_content I18n.t('admin.order.change_state')
      end

      it 'should render the expected batch actions' do
        expect(page).to have_content I18n.t('admin.order.batch_actions.in_progress')
        expect(page).to have_content I18n.t('admin.order.batch_actions.completed')
        expect(page).to have_content I18n.t('admin.order.batch_actions.in_delivery')
        expect(page).to have_content I18n.t('admin.order.batch_actions.delivered')
        expect(page).to have_content I18n.t('admin.order.batch_actions.canceled')
      end
    end

    describe 'GET edit' do
      before do
        get :edit, params: { id: order.id }
      end

      it 'respond with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the author' do
        expect(assigns(:order)).to eq(order)
      end

      it 'should render the form elements' do
        expect(page).to have_field 'order_status'
      end
    end
  end
end

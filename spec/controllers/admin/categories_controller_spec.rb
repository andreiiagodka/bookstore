require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  describe 'not admin user is not allowed to access admin panel' do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'category CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:category) { create(:category) }

    let(:valid_attributes) { attributes_for :category }
    let(:invalid_attributes) { { name: nil } }

    render_views
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the category' do
        expect(assigns(:categories)).to include category
      end

      it 'renders the expected columns' do
        expect(page).to have_content category.name
        expect(page).to have_content I18n.t('admin.actions.view')
        expect(page).to have_content I18n.t('admin.actions.edit')
        expect(page).to have_content I18n.t('admin.actions.delete')
      end
    end

    describe 'GET new' do
      before { get :new }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the category' do
        expect(assigns(:category)).to be_a_new Category
      end

      it 'renders the form elements' do
        expect(page).to have_field 'category_name'
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'creates a new category' do
          expect {
            post :create, params: { category: valid_attributes }
          }.to change(Category, :count).by(1)
        end

        it 'assigns a newly created category as @category' do
          post :create, params: { category: valid_attributes }
          expect(assigns(:category)).to be_a Category
          expect(assigns(:category)).to be_persisted
        end

        it 'redirects to the created category' do
          post :create, params: { category: valid_attributes }
          is_expected.to respond_with 302
          expect(response).to redirect_to admin_category_path(Category.last)
        end

        it 'creates the category' do
          post :create, params: { category: valid_attributes }
          expect(Category.last.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'invalid_attributes respond with 200' do
          post :create, params: { category: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'assigns a newly created but unsaved category as @category' do
          post :create, params: { category: invalid_attributes }
          expect(assigns(:category)).to be_a_new Category
        end

        it 'invalid_attributes do not create a category' do
          expect do
            post :create, params: { category: invalid_attributes }
          end.not_to change(Category, :count)
        end
      end
    end

    describe 'GET edit' do
      before do
        get :edit, params: { id: category.id }
      end

      it 'respond with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'renders the form elements' do
        expect(page).to have_field 'category_name'
      end
    end

    describe 'PUT update' do
      context 'with valid params' do
        before do
          put :update, params: { id: category.id, category: valid_attributes }
        end

        it 'assigns the category' do
          expect(assigns(:category)).to eq(category)
        end

        it 'responds with 302' do
          is_expected.to respond_with 302
          expect(response).to redirect_to(admin_category_path(category))
        end

        it 'updates the person' do
          category.reload
          expect(category.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'responds with 200' do
          put :update, params: { id: category.id, category: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'does not change category' do
          expect do
            put :update, params: { id: category.id, category: invalid_attributes }
          end.not_to change { category.reload.name }
        end
      end
    end

    describe 'GET show' do
      before do
        get :show, params: { id: category.id }
      end

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the category' do
        expect(assigns(:category)).to eq category
      end

      it 'renders the form elements' do
        expect(page).to have_content(category.name)
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested category' do
        expect {
          delete :destroy, params: { id: category.id }
        }.to change(Category, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to(admin_categories_path)
      end
    end
  end
end

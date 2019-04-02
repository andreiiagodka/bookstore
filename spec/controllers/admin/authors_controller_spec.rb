require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do
  describe "not admin user is not allowed to access admin panel" do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'authors CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:author) { create(:author) }

    let(:valid_attributes) { attributes_for :author }
    let(:invalid_attributes) { { name: nil } }

    render_views
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the author' do
        expect(assigns(:authors)).to include author
      end

      it 'should render the expected columns' do
        expect(page).to have_content author.name
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

      it 'assigns the author' do
        expect(assigns(:author)).to be_a_new Author
      end

      it 'should render the form elements' do
        expect(page).to have_field 'author_name'
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'creates a new Author' do
          expect {
            post :create, params: { author: valid_attributes }
          }.to change(Author, :count).by(1)
        end

        it 'assigns a newly created author as @author' do
          post :create, params: { author: valid_attributes }
          expect(assigns(:author)).to be_a Author
          expect(assigns(:author)).to be_persisted
        end

        it 'redirects to the created author' do
          post :create, params: { author: valid_attributes }
          is_expected.to respond_with 302
          expect(response).to redirect_to admin_author_path(Author.last)
        end

        it 'should create the author' do
          post :create, params: { author: valid_attributes }
          expect(Author.last.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'invalid_attributes respond with 200' do
          post :create, params: { author: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'assigns a newly created but unsaved author as @author' do
          post :create, params: { author: invalid_attributes }
          expect(assigns(:author)).to be_a_new Author
        end

        it 'invalid_attributes do not create a Author' do
          expect do
            post :create, params: { author: invalid_attributes }
          end.not_to change(Author, :count)
        end
      end
    end

    describe 'GET edit' do
      before do
        get :edit, params: { id: author.id }
      end

      it 'respond with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the author' do
        expect(assigns(:author)).to eq(author)
      end

      it 'should render the form elements' do
        expect(page).to have_field 'author_name'
      end
    end

    describe 'PUT update' do
      context 'with valid params' do
        before do
          put :update, params: { id: author.id, author: valid_attributes }
        end

        it 'assigns the author' do
          expect(assigns(:author)).to eq(author)
        end

        it 'responds with 302' do
          is_expected.to respond_with 302
          expect(response).to redirect_to(admin_author_path(author))
        end

        it 'should update the person' do
          author.reload
          expect(author.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'responds with 200' do
          put :update, params: { id: author.id, author: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'does not change author' do
          expect do
            put :update, params: { id: author.id, author: invalid_attributes }
          end.not_to change { author.reload.name }
        end
      end
    end

    describe "GET show" do
      before do
        get :show, params: { id: author.id }
      end

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the author' do
        expect(assigns(:author)).to eq author
      end

      it 'should render the form elements' do
        expect(page).to have_content(author.name)
      end
    end

    describe "DELETE destroy" do
      it 'destroys the requested author' do
        expect {
          delete :destroy, params: { id: author.id }
        }.to change(Author, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: author.id }
        expect(response).to redirect_to(admin_authors_path)
      end
    end
  end
end

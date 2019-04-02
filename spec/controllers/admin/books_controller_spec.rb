require 'rails_helper'

RSpec.describe Admin::BooksController, type: :controller do
  describe "not admin user is not allowed to access admin panel" do
    it do
      get :index
      expect(subject).to redirect_to(admin_user_session_path)
    end
  end

  describe 'book CRUD' do
    let(:page) { Capybara::Node::Simple.new(response.body) }
    let!(:book) { create(:book, :attach_cover, :attach_category, :attach_author).decorate }

    let(:valid_attributes) { (attributes_for :book).merge(category: create(:category), author: create(:author)) }
    let(:invalid_attributes) { { name: nil } }

    render_views
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the book' do
        expect(assigns(:books)).to include book
      end

      it 'should render the expected columns' do
        expect(page).to have_content book.categories_as_string
        expect(page).to have_content book.name
        expect(page).to have_content book.authors_as_string
        expect(page).to have_content book.short_description
        expect(page).to have_content I18n.t('price', price: book.price)
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

      it 'assigns the book' do
        expect(assigns(:book)).to be_a_new Book
      end

      it 'should render the form elements' do
        expect(page).to have_field 'book_name'
        expect(page).to have_field 'book_description'
        expect(page).to have_field 'book_price'
        expect(page).to have_field 'book_publication_year'
        expect(page).to have_field 'book_height'
        expect(page).to have_field 'book_width'
        expect(page).to have_field 'book_depth'
        expect(page).to have_field 'book_material'
        expect(page).to have_content I18n.t('admin.book.categories')
        expect(page).to have_content I18n.t('admin.book.authors')
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'creates a new Book' do
          expect {
            post :create, params: { book: valid_attributes }
          }.to change(Book, :count).by(1)
        end

        it 'assigns a newly created book as @book' do
          post :create, params: { book: valid_attributes }
          expect(assigns(:book)).to be_a Book
          expect(assigns(:book)).to be_persisted
        end

        it 'redirects to the created book' do
          post :create, params: { book: valid_attributes }
          is_expected.to respond_with 302
          expect(response).to redirect_to admin_book_path(Book.last)
        end

        it 'should create the book' do
          post :create, params: { book: valid_attributes }
          expect(Book.last.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'invalid_attributes respond with 200' do
          post :create, params: { book: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'assigns a newly created but unsaved book as @book' do
          post :create, params: { book: invalid_attributes }
          expect(assigns(:book)).to be_a_new Book
        end

        it 'invalid_attributes do not create a Book' do
          expect do
            post :create, params: { book: invalid_attributes }
          end.not_to change(Book, :count)
        end
      end
    end

    describe 'GET edit' do
      before do
        get :edit, params: { id: book.id }
      end

      it 'respond with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the book' do
        expect(assigns(:book)).to eq(book)
      end

      it 'should render the form elements' do
        expect(page).to have_field 'book_name'
        expect(page).to have_field 'book_description'
        expect(page).to have_field 'book_price'
        expect(page).to have_field 'book_publication_year'
        expect(page).to have_field 'book_height'
        expect(page).to have_field 'book_width'
        expect(page).to have_field 'book_depth'
        expect(page).to have_field 'book_material'
        expect(page).to have_content I18n.t('admin.book.categories')
        expect(page).to have_content I18n.t('admin.book.authors')
      end
    end

    describe 'PUT update' do
      context 'with valid params' do
        before do
          put :update, params: { id: book.id, book: valid_attributes }
        end

        it 'assigns the book' do
          expect(assigns(:book)).to eq(book)
        end

        it 'responds with 302' do
          is_expected.to respond_with 302
          expect(response).to redirect_to(admin_book_path(book))
        end

        it 'should update the person' do
          book.reload
          expect(book.name).to eq valid_attributes[:name]
        end
      end

      context 'with invalid params' do
        it 'responds with 200' do
          put :update, params: { id: book.id, book: invalid_attributes }
          is_expected.to respond_with 200
        end

        it 'does not change book' do
          expect do
            put :update, params: { id: book.id, book: invalid_attributes }
          end.not_to change { book.reload.name }
        end
      end
    end

    describe "GET show" do
      before do
        get :show, params: { id: book.id }
      end

      it 'responds with 200' do
        is_expected.to respond_with 200
      end

      it 'assigns the book' do
        expect(assigns(:book)).to eq book
      end

      it 'should render the form elements' do
        expect(page).to have_content(book.name)
        expect(page).to have_content(book.description)
        expect(page).to have_content(book.price)
        expect(page).to have_content(book.publication_year)
        expect(page).to have_content(book.height)
        expect(page).to have_content(book.width)
        expect(page).to have_content(book.depth)
        expect(page).to have_content(book.material)
      end
    end

    describe "DELETE destroy" do
      it 'destroys the requested book' do
        expect {
          delete :destroy, params: { id: book.id }
        }.to change(Book, :count).by(-1)
      end

      it 'redirects to the field' do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to(admin_books_path)
      end
    end
  end
end

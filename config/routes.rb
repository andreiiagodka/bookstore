Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }

  root 'pages#home'

  resources :books, only: [:index, :show]
  resources :categories do
    resources :books, only: :index
  end
  resources :reviews, only: :create
  resources :orders
  resources :order_books
  resources :coupons
  resources :checkout
end

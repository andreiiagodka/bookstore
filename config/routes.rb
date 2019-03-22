Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'

  resources :books, only: [:index, :show]
  resources :categories do
    resources :books, only: :index
  end
  resources :orders
  resources :reviews, only: :create
  resources :order_books
  resources :coupons
  resources :checkout
  resources :users do
    resources :orders, only: [:index, :show]
  end
  resources :addresses
end

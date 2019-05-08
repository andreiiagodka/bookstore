Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/users', to: redirect('/users/sign_up')
  root 'pages#home'

  resources :addresses, only: [:create, :update]
  resources :books, only: [:index, :show]
  resources :checkout, only: [:show, :update]
  resources :coupons, only: :update
  resources :orders, only: [:index, :show]
  resources :order_books, only: [:create, :update, :destroy]
  resources :reviews, only: :create

  resources :categories, only: [:index, :show] do
    resources :books, only: :index
  end

  resources :users, only: [:show, :update, :destroy] do
    resources :orders, only: [:index, :show]
  end
end

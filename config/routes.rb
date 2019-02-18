Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'pages#home'

  resources :books, only: [:index, :show]
  resources :categories
  resources :reviews, only: :create
  resources :order_books
end

Rails.application.routes.draw do
  get 'shopping_carts/show'
  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :products

  resources :recipes

  resource :shopping_cart, only: [:show] do
    put 'add/:product_id', to: 'shopping_carts#add', as: :add_to
    put 'remove/:product_id', to: 'shopping_carts#remove', as: :remove_from
  end

  resources :orders


  resource :checkout

  resource :account

  resources :notifications, only: [:index, :show]

  namespace :admin do
    resources :products
    resources :orders
    resources :activity, only: [:index]
  end

  get 'admin' => 'admin#index'

  get 'home' => 'home#index'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
